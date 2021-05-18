(* ::Package:: *)

(* :Title:InstrumentQuiz*)
(* :Context:InstrumentQuiz`*)
(* :Author:VT*)
(* :Summary:instrument quiz package*)
(* :Copyright:*)
(* :Package Version:1,Maggio 2020*)
(* :Mathematica Version:11.2*)
(* :History:*)
(* :Sources:*)
(* :Limitations:*)(* :Discussion:*)


BeginPackage["InstrumentQuiz`"];


path = StringReplace[NotebookDirectory[],"package\\" -> ""];



MakeTypeQuiz::usage="MakeInstrumentQuiz []
Create some random exercise  with type of an instrument.";

MakeTFQuiz::usage="MakeInstrumentQuiz []
Create some random exercise with T/F questions.";

MakeNameQuiz::usage="MakeInstrumentQuiz []
Create some random exercise check name of an instrument.";

MakeSoundQuiz::usage="MakeSoundQuiz []
Create some random exercise check the instrument that played the melody.";

$instrumentList::usage="$instrumentList
Is the global luist of instrument.";

$instrumentList = { 
{"Batteria","Percussione"},
{"Clarinetto","Fiato"},
{"Piano","Corda"},
{"Pianola","Tastiera"},
{"Sassofono soprano","Fiato"},
{"Tamburo","Percussione"},
{"Viola","Corda"} ,
{"Violino","Corda"},
{"Violoncello","Corda"}
};
$instrumentSoundList = {{"Piano", "Pianoforte"}, {"Guitar","Chitarra"}, {"Cello", "Violoncello"}, {"Trumpet", "Tromba"}};


quizList = {
{"L'archetto \[EGrave] una bacchetta di legno con dei fili di metallo tesi.",
"Falso",
"Falso. Si tratta di una bacchetta di legno con dei crini di cavallo tesi."
},

{"L'archetto \[EGrave] un accessorio che serve per suonare strumenti dotati di corde come il violino.",
"Vero",
"Vero. Serve per suonare anche la viola, il violoncello e il contrabbasso."
},

{"L'ancia \[EGrave] una linguetta mobile che produce il suono di alcuni strumenti a fiato.",
"Vero",
"Vero. Il suono viene prodotto dalla vibrazione dell'ancia causata dall'ingresso dell'aria."
},

{"L'Oboe \[EGrave] uno strumento ad ancia semplice.",
"Falso",
"Falso. L'Oboe \[EGrave] uno strumento ad ancia doppia."
},

{"Il clarinetto \[EGrave] uno strumento della famiglia degi ottoni.",
"Falso",
"Falso. Il clarinetto appartiene alla famiglia dei legni."
},
{
"Il pianoforte \[EGrave] uno strumento a corde percosse.",
"Vero",
"Vero. Le corde vengono percosse da dei martelletti azionati dalla tastiera."
},

{"Il liuto \[EGrave] uno strumento a corde pizzicate.",
"Vero",
"Vero. Il liuto \[EGrave] uno strumento europeo del barocco/rinascimento che viene suonato tramite il pizzico delle corde."
},
{"Lo xilofono \[EGrave] uno strumento membranofono.",
"Falso",
"Falso. Lo xilofono \[EGrave] uno strumento idiofono cio\[EGrave] privo di membrana."
},
{"Il timpano \[EGrave] uno strumento membranofono.",
"Vero",
"Vero, Il timpano \[EGrave] considerato il re dei membranofoni."
}

};

tempquizList = quizList;
For[i = 1, i <= Length[$instrumentList],i++,
sub = $instrumentList[[i]];
pic = Import[path <> "immagini/strumenti/"<>sub[[1]]<>".jpg"];
$instrumentList[[i]] = Append[$instrumentList[[i]],pic];
]
$instrumentListName = $instrumentList;


Begin["Private`"];



(* Funzione usata per la creazione di un quiz vero o falso *)
MakeTFQuiz[] := Module[
{random = 0,sub = Null,list = tempquizList},
toChooseTF = {"Vero","Falso"};
If[Length[list] == 0, 
text = "Hai completato gli esercizi di vero o falso!";
pan = Panel[
Row[{Style[Dynamic[text],FontFamily->"Arial-Bold",16]}]
,ImageSize->700];
Print[pan];
Return[pan];
,
SeedRandom[];
random = RandomInteger[{1,Length[list]}]; (*Scelta elemento*)
	sub = list[[random]];
	question =  sub[[1]];
	answer = sub[[2]];
	explain = sub[[3]];
	userAnswer = Null;
answered = False;
tempquizList = Delete[tempquizList,random]; (*rimozione elemento per evitare ripetizione*)
	panel = Panel[
Column[{
		(*visualizzazione domanda*)
		Row[{Style[Dynamic[question],FontFamily->"Arial-Bold",16]}],
		Spacer[225 0.7],
		(*scelta risposta*)
		Row[{RadioButtonBar[Dynamic[userAnswer],toChooseTF ,Appearance->"Orizzontal"] }],
		Row[{ 
			(* Bottone utilizzato per controllare se la risposta data \[EGrave] corretta o sbagliata *)
			Button["Invio",
				(* Controllo utilizzato per verificare se l'utente ha risposto ed in che modo, con relativa spiegazione *)
				If[userAnswer == answer,
					answered = True; MessageDialog["Esatto! " <> explain],
					answered = True; MessageDialog["Sbagliato! " <> explain],
					MessageDialog["Seleziona una risposta!"]
				]
			],
			Spacer[80 0.7],
			(* Bottone utilizzato per passare alla successiva esecuzione del quiz vero o falso *)
			Button["Avanti",
				(* Controllo utilizzato per verificare se l'utente ha risposto *)
				If[answered == True,
					MakeTFQuiz[],
					MessageDialog["Devi prima rispondere alla domanda!"],
					MessageDialog["Devi prima rispondere alla domanda!"]
				]
			],
			Spacer[20 0.7],
			(*per ricaricare la lista di domande*)
			Button["Ricarica domande", tempquizList = quizList;MakeTFQuiz[]; ]
}]
}]
	,ImageSize->700];
Return[panel];

];


]

(* Funzione usata per la creazione di un quiz sul nome di uno strumento *)
MakeNameQuiz[prev_:0] := Module[
{ list = $instrumentListName, sub = Null},

SeedRandom[]; (*Ogni volta diverso per cercare di generare sempre numeri random*)
randomName = RandomInteger[{1,Length[list]}];
If[prev == randomName,
MakeNameQuiz[prev] (*Evitare ripetizione*)
];
(*Random choice of a instrument*)
sub = list[[randomName]];
list = Delete[list,randomName];
pictureName = sub[[3]];
name = sub[[1]];
userAnswerName = Null;
answeredName = False;
toChooseName = {}; (*Random list of instrument name*)
For[answer = 1, answer <= 3,answer++,
	SeedRandom[];
	random = RandomInteger[{1,Length[list]}];
  elem =list[[random]];
  toChooseName = Append[toChooseName,elem[[1]]];
list = Delete[list,random];
];
newPos = RandomInteger[{1,3}];
toChooseName = Insert[toChooseName,name,newPos];
panel = Panel[
Row[{
Style[Dynamic["Che strumento e' quello in foto?"],FontFamily->"Arial-Bold",16],
Column[{
Magnify[Dynamic[pictureName],4.5]
}],
Spacer[225 0.7],
Column[{
Row[{Dynamic[RadioButtonBar[Dynamic[userAnswerName],toChooseName,Appearance->"Vertical"]]}],
Row[{
			(* Bottone utilizzato per controllare se la risposta data \[EGrave] corretta o sbagliata *)
			Button["Invio",
				(* Controllo utilizzato per verificare se l'utente ha risposto ed in che modo *)
				If[userAnswerName == name,
					answeredName = True; MessageDialog["Esatto!"],
					answeredName = True; MessageDialog["Sbagliato!"],
	                                 MessageDialog["Seleziona una risposta!"]
				]
			],
			Spacer[20 0.7],
			(* Bottone utilizzato per passare alla successiva esecuzione del quiz sui nomi *)
			Button["Avanti",
			(* Controllo utilizzato per verificare se l'utente ha precedentemente dato la risposta corretta, altrimenti deve continuare fino a risposta corretta prima di poter proseguire *)
				If[answeredName == True,
					MakeNameQuiz[randomName],
					MessageDialog["Devi prima rispondere alla domanda!"],
					MessageDialog["Devi prima rispondere alla domanda!"]
]
	]
}]
}],
Spacer[15 0.7]
}]
,ImageSize->700];

Return[panel];

]


(* Funzione usata per la creazione di un quiz di tipo *)
MakeTypeQuiz[prev_:0] := Module[
{ list = $instrumentList, sub = Null},
toChooseType = {"Fiato","Percussione","Tastiera","Corda"};
SeedRandom[];
randomType = RandomInteger[{1,Length[list]}];
If[prev == randomType,
MakeTypeQuiz[prev] (*Evitare ripetizione*)
];
(*Random choice of a instrument*)
sub = list[[randomType]];
pictureType = sub[[3]];
nameType = sub[[2]];
userAnswerType = Null;
answeredType = False;
panelType = Panel[
Row[{
Style[Dynamic["Che tipo di strumento e' quello in foto?"],FontFamily->"Arial-Bold",16],
Column[{
Magnify[Dynamic[pictureType],4.5]
}],
Spacer[225 0.7],
Column[{
Row[{Dynamic[RadioButtonBar[Dynamic[userAnswerType],toChooseType,Appearance->"Vertical"]]}],
Row[{
			(* Bottone utilizzato per controllare se la risposta data \[EGrave] corretta o sbagliata *)
			Button["Invio",
				(* Controllo utilizzato per verificare se l'utente ha risposto ed in che modo *)
				If[userAnswerType == nameType,
					answeredType = True; MessageDialog["Esatto!"],
					answeredType = True; MessageDialog["Sbagliato!"],
	                                 MessageDialog["Seleziona una risposta!"]
				]
			],
			Spacer[20 0.7],
			(* Bottone utilizzato per passare alla successiva esecuzione del quiz sui tipi *)
			Button["Avanti",
				(* Controllo utilizzato per verificare se l'utente ha precedentemente dato la risposta corretta, altrimenti deve continuare fino a risposta corretta prima di poter proseguire *)
				If[answeredType == True,
					MakeTypeQuiz[randomType],
					MessageDialog["Devi prima rispondere alla domanda!"],
					MessageDialog["Devi prima rispondere alla domanda!"]
]
	]
}]
}],
Spacer[15 0.7]
}]
,ImageSize->700];
Return[panelType];

]

(* Funzione usata per la creazione di un quiz musicale *)
MakeSoundQuiz[prev_:0] := DynamicModule[
{list = $instrumentSoundList,sub = Null},
toChooseSound = {"Pianoforte","Chitarra","Violoncello", "Tromba"};
SeedRandom[];
(* Scelta casuale dello strumento che ripeter\[AGrave] la melodia *)
randomSound = RandomInteger[{1,Length[list]}];
(* If utilizzato per evitare che la melodia possa essere eseguita con lo stesso strumento rispetto alla prova precedente *)
If[prev == randomSound,
MakeSoundQuiz[prev]
];
sub = list[[randomSound]];
answerSound = sub[[2]];
instrument = sub[[1]];
choosenSound = "";
answeredSound = False;
(* Creazione del panel per il quiz musicale *)
panel = Panel[
Row[{
Column[{
Dynamic[
(* Barra per la riproduzione del ritornello della canzone "The Final Countdown" *)
Sound[{
(* Nella prima parte viene selezionata la nota da riprodurre, nella seconda l'intervallo di tempo e nell'ultima lo strumento *)
SoundNote["E5", 0.125, instrument],
SoundNote["D5", 0.125, instrument],
SoundNote["E5", 0.50, instrument],
SoundNote["A4", 0.50, instrument],
SoundNote[None, 0.75, instrument],
SoundNote["F5", 0.125, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["F5", 0.25, instrument],
SoundNote["E5", 0.25, instrument],
SoundNote["D5", 0.50, instrument],
SoundNote[None, 0.75, instrument],
SoundNote["F5", 0.125, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["F5", 0.50, instrument],
SoundNote["A4", 0.5, instrument],
SoundNote[None, 0.75, instrument],
SoundNote["D5", 0.125, instrument],
SoundNote["C5", 0.125, instrument],
SoundNote["D5", 0.25, instrument],
SoundNote["C5", 0.25, instrument],
SoundNote["B4", 0.25, instrument],
SoundNote["D5", 0.25, instrument],
SoundNote["C5", 0.50, instrument],
SoundNote[None, 0.25, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["D5", 0.125, instrument],
SoundNote["E5", 0.50, instrument],
SoundNote["A4", 0.50, instrument],
SoundNote[None, 0.75, instrument],

SoundNote["F5", 0.125, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["F5", 0.25, instrument],
SoundNote["E5", 0.25, instrument],
SoundNote["D5", 0.50, instrument],
SoundNote[None, 0.75, instrument],
SoundNote["F5", 0.125, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["F5", 0.50, instrument],
SoundNote["A4", 0.5, instrument],
SoundNote[None, 0.75, instrument],
SoundNote["D5", 0.125, instrument],
SoundNote["C5", 0.125, instrument],
SoundNote["D5", 0.25, instrument],
SoundNote["C5", 0.25, instrument],
SoundNote["B4", 0.25, instrument],
SoundNote["D5", 0.25, instrument],
SoundNote["C5", 0.50, instrument],
SoundNote[None, 0.25, instrument],


SoundNote["E5", 0.125, instrument],
SoundNote["D5", 0.125, instrument],
SoundNote["E5", 0.50, instrument],
SoundNote["A4", 0.50, instrument],
SoundNote[None, 0.75, instrument],
SoundNote["F5", 0.125, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["F5", 0.25, instrument],
SoundNote["E5", 0.25, instrument],
SoundNote["D5", 0.50, instrument],
SoundNote[None, 0.75, instrument],
SoundNote["F5", 0.125, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["F5", 0.50, instrument],
SoundNote["A4", 0.5, instrument],
SoundNote[None, 0.75, instrument],
SoundNote["D5", 0.125, instrument],
SoundNote["C5", 0.125, instrument],
SoundNote["D5", 0.25, instrument],
SoundNote["C5", 0.25, instrument],
SoundNote["B4", 0.25, instrument],
SoundNote["D5", 0.25, instrument],
SoundNote["C5", 0.50, instrument],
SoundNote[None, 0.25, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["D5", 0.125, instrument],
SoundNote["E5", 0.50, instrument],
SoundNote["A4", 0.50, instrument],


SoundNote[None, 0.75, instrument],
SoundNote["F5", 0.125, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["F5", 0.25, instrument],
SoundNote["E5", 0.25, instrument],
SoundNote["D5", 0.50, instrument],
SoundNote[None, 0.75, instrument],
SoundNote["F5", 0.125, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["F5", 0.50, instrument],
SoundNote["A4", 0.5, instrument],
SoundNote[None, 0.75, instrument],
SoundNote["D5", 0.125, instrument],
SoundNote["C5", 0.125, instrument],
SoundNote["D5", 0.25, instrument],
SoundNote["C5", 0.25, instrument],
SoundNote["B4", 0.25, instrument],
SoundNote["D5", 0.25, instrument],
SoundNote["C5", 0.75, instrument],
SoundNote["B4", 0.125, instrument],
SoundNote["C5", 0.125, instrument],
SoundNote["D5", 0.75, instrument],
SoundNote["C5", 0.125, instrument],
SoundNote["D5", 0.125, instrument],
SoundNote["E5", 0.25, instrument],
SoundNote["D5", 0.25, instrument],
SoundNote["C5", 0.25, instrument],
SoundNote["B4", 0.25, instrument],
SoundNote["A4", 0.50, instrument],
SoundNote["F5", 0.50, instrument],
SoundNote["E5", 1, instrument],
SoundNote["E5", 0.25, instrument],
SoundNote["F5", 0.50, instrument],
SoundNote["E5", 0.125, instrument],
SoundNote["D5", 0.125, instrument],
SoundNote["E5", 2, instrument]
}]
]
}],
Spacer[225 0.7],
Column[{
(* Creazione delle possibili risposte tra cui l'utente dovr\[AGrave] scegliere *)
Row[{Dynamic[RadioButtonBar[Dynamic[choosenSound],toChooseSound,Appearance->"Vertical"]]}],
Row[{
(* Bottone utilizzato per controllare se la risposta data \[EGrave] corretta o sbagliata *)
Button["Invio",
(* Controllo utilizzato per verificare se l'utente ha risposto ed in che modo *)
If[choosenSound == answerSound,
answeredSound = True; MessageDialog["Esatto!"],
MessageDialog["Sbagliato!"],
MessageDialog["Seleziona una risposta!"]
]
]
}],
Row[{
(* Bottone utilizzato per passare alla successiva esecuzione del quiz musicale *)
Button["Avanti",
(* Controllo utilizzato per verificare se l'utente ha precedentemente dato la risposta corretta, altrimenti deve continuare fino a risposta corretta prima di poter proseguire *)
If[answeredSound == True,
					MakeSoundQuiz[randomSound],
					MessageDialog["Devi prima rispondere alla domanda!"],
					MessageDialog["Devi prima rispondere alla domanda!"]
]
]
}]
}],
Spacer[15 0.7]
}]
,ImageSize->700]

]


End[]
EndPackage[]
