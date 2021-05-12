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




toLabelList[{}]:= Module[{},Return["--"]]; 
toLabelList[toConv_  /; listOfList[toConv] == False, toApp_,type_]:=Module[
{notesStart = {},notesEnd = {}, i = 1,toConvert = toConv, toAppend = toApp},
If[type == "u",
notesStart =$notesEU;
notesEnd = $notesUS,
notesStart =$notesUS;
notesEnd = $notesEU;
];
(*toConvert = removeNumber[toConvert];*)
lenList = Length[toConvert] + 1;
temp = toAppend;
For[i=1,i<  lenList,i++,

index1 =FirstPosition[notesStart,toConvert[[i]]];
newElem = Part[notesEnd[[index1]],1];
temp = Append[temp, newElem];

 ];
Return[temp];
]

toLabelList[toConv_/; listOfList[toConv] == True,toApp_,type_]:=Module[
{notesStart = {},notesEnd = {}, i = 1,toConvert = toConv, toAppend = toApp, lenList = Length[toConv] +1},
If[type == "u",
notesStart =$notesEU;
notesEnd = $notesUS,

notesStart =$notesUS;
notesEnd = $notesEU
];
(*toConvert = removeNumber[toConvert];*)
temp = toAppend;
For[i=1,i <  lenList,i++, 
If[
Length[toConvert[[i]]] == 0,

index2 =FirstPosition[notesStart,toConvert[[i]]]; (*then*)
newElem = Part[notesEnd[[index2]],1];
temp = Append[temp, newElem];  ,

newTemp = {};
newList = toConvert[[i]];
temp = Append[temp,toLabelList[newList,newTemp ,type]] ;(*else*)
];
];
Return[temp]
]


createSpartitoList[list_]:= Module[
{i = 1},
temp = {};
lenList = Length[list] +1;
For[i=1,i <  lenList,i++, 
If[Length[list[[i]]] == 0,
temp = AppendTo[temp, List[list[[i]]]];
,
temp = AppendTo[temp, list[[i]]];

];
];
Return[temp];
];

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
