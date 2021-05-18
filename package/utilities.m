(* ::Package:: *)

(* :Title:MusicUtilities*)
(* :Context:MusicUtilities`*)
(* :Author:VT*)
(* :Summary:music lesson utilities*)
(* :Copyright:*)
(* :Package Version:1,Maggio 2020*)
(* :Mathematica Version:11.2*)
(* :History:*)
(* :Sources:*)
(* :Limitations:*)(* :Discussion:*)


BeginPackage["MusicUtilities`"];


$baseUs = {"C","D","E","F","G","A","B"};
$baseEu = {"Do","Re","Mi","Fa","Sol","La","Si"};

$notesUS = {};
$notesEU = {};
For[note = 0, note< 8, note++,
subNote = "";
If[note == 0, subNote = "", subNote = ToString[note]];
For[ind = 1, ind<= 7,ind++,
usElem = $baseUs[[ind]]<>subNote;
euElem = $baseEu[[ind]]<>subNote;
$notesUS = Append[$notesUS, usElem ];
$notesEU = Append[$notesEU, euElem]
];
]

listOfList::usage="listOfList [list]
Check if a list have another list inside.";


toLabelList::usage="toLabelList [toConv,toApp,type]
Convert the list of musical notes (toConv) into the sistem specified by type ('u' : us, 'e': eu).";

createSpartitoList::usage="createSpartitoList [list]
Just prepare the list to be used from a music score draw function .";

removeBrackets::usage="removeBrackets [list]
Remove brackets from a list of list to a string list";

Begin["`Private`"];

(*
	serve per discriminare le due funzioni ricorsive in modo da avere true o false sulla lista come paremetro
	per sapere se ha all'interno un'altra lista.
*)
listOfList[toCheck_] := Module[
{i = 1,toRet = False},
lenList = Length[toCheck];
For[i=1,i<  lenList+1,i++,
If[Length[toCheck[[i]]] != 0,
toRet = True; i = lenList;
]
] ;
Return[toRet];                     
]




(*
	toLabelList riceve una lista di note e crea una lista di note corrispondenti nel formato europeo/US in modo da poter far vedere 
	all'utente entrambi i formati di note. Si richiede in input una lista di note e il formato in cui si desidera l'outuput.
*)

(*Caso lista vuota*)
toLabelList[{}]:= Module[{},Return["--"]]; 

(*Caso lista di note*)
toLabelList[toConv_  /; listOfList[toConv] == False, toApp_,type_]:=Module[
{notesStart = {},notesEnd = {}, i = 1,toConvert = toConv, toAppend = toApp},
If[type == "u",
notesStart =$notesEU; (*scelta del formato di partenza e di arrivo*)
notesEnd = $notesUS,
notesStart =$notesUS;
notesEnd = $notesEU;
];

lenList = Length[toConvert] + 1;
temp = toAppend;
For[i=1,i<  lenList,i++,
(*selezione dell'elemento*)
index1 =FirstPosition[notesStart,toConvert[[i]]];
newElem = Part[notesEnd[[index1]],1];
temp = Append[temp, newElem];

 ];
Return[temp];
]

(*Caso lista di liste di note*)

toLabelList[toConv_/; listOfList[toConv] == True,toApp_,type_]:=Module[
{notesStart = {},notesEnd = {}, i = 1,toConvert = toConv, toAppend = toApp, lenList = Length[toConv] +1},
If[type == "u",
notesStart =$notesEU; (*selezione formato*)
notesEnd = $notesUS,

notesStart =$notesUS;
notesEnd = $notesEU
];
temp = toAppend;
For[i=1,i <  lenList,i++, 
If[
Length[toConvert[[i]]] == 0,
(*Aggiunta dell'elemento*)
index2 =FirstPosition[notesStart,toConvert[[i]]]; (*then*)
newElem = Part[notesEnd[[index2]],1];
temp = Append[temp, newElem];  ,

newTemp = {};
newList = toConvert[[i]];
(*chiamata ricorsiva con la sottolista*)
temp = Append[temp,toLabelList[newList,newTemp ,type]] ;(*else*)
];
];
Return[temp]
]


(*
	createSpartitoList aggiunge attorno ad ogni nota delle parentesi graffe, 
	necessaria per compatibilita' con la funzione PrintPart[spartitoList]
*)

createSpartitoList[list_]:= Module[
{i = 1},
temp = {};
lenList = Length[list] +1;
For[i=1,i <  lenList,i++, 
If[Length[list[[i]]] == 0,
(*Se e' solo un elemento *)
temp = AppendTo[temp, List[list[[i]]]];
,
(*Se e' una lista lo aggiungo direttamente *)
temp = AppendTo[temp, list[[i]]];

];
];
Return[temp];
];

(*Rimuove le graffe intorno alle note *)
removeBrackets[list_]:= Module[
{i = 1},
noBraList = {};
len = Length[list];
For[i = 1, i <=  len, i++,
let = StringReplace[ToString[list[[i]]], {"{" -> "" ,"}" -> ""}];
noBraList = Append[noBraList, let];
];
Return[noBraList];
]



End[]
EndPackage[]
