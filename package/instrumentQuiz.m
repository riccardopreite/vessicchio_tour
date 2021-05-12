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


MakeInstrumentQuiz::usage="MakeInstrumentQuiz []
Create some random exercise  with instrument, check name, type of an instrument.";

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
{"Piano","Tastiera"},
{"Pianola","Tastiera"},
{"Sassofono soprano","Fiato"},
{"Tamburo","Percussione"},
{"Viola","Corda"} ,
{"Violino","Corda"},
{"Violoncello","Corda"}
};
$instrumentSoundList = {{"Piano", "Pianoforte"}, {"BaritoneSax","Sassofono"}, {"Guitar","Chitarra"}, {"Cello", "Violoncello"}, {"Trumpet", "Tromba"}};


quizList = {
{"L'archetto \[EGrave] una bacchetta di legno con dei fili di metallo tesi.",
"F",
"Falso. Si tratta di una bacchetta di legno con dei crini di cavallo tesi."
},

{"L'archetto \[EGrave] un accessorio che serve per suonare strumenti dotati di corde come il violino.",
"V",
"Vero. Serve per suonare anche la viola, il violoncello e il contrabbasso."
},

{"L'ancia \[EGrave] una linguetta mobile che produce il suono di alcuni strumenti a fiato.",
"V",
"Vero. Il suono viene prodotto dalla vibrazione dell'ancia causata dall'ingresso dell'aria."
},

{"L'Oboe \[EGrave] uno strumento ad ancia semplice.",
"F",
"Falso. L'Oboe \[EGrave] uno strumento ad ancia doppia."
},

{"Il clarinetto \[EGrave] uno strumento della famiglia degi ottoni.",
"F",
"Falso. Il clarinetto appartiene alla famiglia dei legni."
},
{
"Il pianoforte \[EGrave] uno strumento a corde percosse.",
"V",
"Vero. Le corde vengono percosse da dei martelletti azionati dalla tastiera."
},

{"Il liuto \[EGrave] uno strumento a corde pizzicate.",
"V",
"Vero. Il liuto \[EGrave] uno strumento europeo del barocco/rinascimento che viene suonato tramite il pizzico delle corde."
},
{"Lo xilofono \[EGrave] uno strumento membranofono.",
"F",
"Falso. Lo xilofono \[EGrave] uno strumento idiofono cio\[EGrave] privo di membrana."
},
{"Il timpano \[EGrave] uno strumento membranofono.",
"V",
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

MakeInstrumentQuiz[] := Module[
{random = 0,ret = Null},
SeedRandom[];
tempquizList = quizList;
]


MakeTFQuiz[] := Module[
{random = 0,sub = Null,list = tempquizList},

If[Length[list] == 0, 
text = "Hai completato gli esercizi di vero o falso!";
pan = Panel[
Row[{Style[Dynamic[text],FontFamily->"Arial-Bold",16]}]
,ImageSize->700];
Print[pan];
Return[pan];
,
SeedRandom[];
random = RandomInteger[{1,Length[list]}];
	sub = list[[random]];
	question =  sub[[1]];
	answer = sub[[2]];
	explain = sub[[3]];
	userAnswer = Null;
answered = False;
tempquizList = Delete[tempquizList,random];
	panel = Panel[
Column[{
		Row[{Style[Dynamic[question],FontFamily->"Arial-Bold",16]}],
		Spacer[225 0.7],
		Row[{RadioButtonBar[Dynamic[userAnswer],{"V"->"Vero","F"->"Falso"}] }],
		Row[{ 
			Button["Submit",
				If[userAnswer == answer,
					answered = True; MessageDialog["Esatto! " <> explain],
					answered = True; MessageDialog["Sbagliato! " <> explain],
					MessageDialog["Seleziona una risposta!"]
				]
			],
			Button["Next",
				If[answered == True,
					MakeTFQuiz[],
					MessageDialog["Devi prima rispondere alla domanda!"],
					MessageDialog["Devi prima rispondere alla domanda!"]
				]
			]
}]
}]
	,ImageSize->700];
Return[panel];

];


]

MakeNameQuiz[] := Module[
{ list = $instrumentListName,random = 0, sub = Null},

SeedRandom[];
random = RandomInteger[{1,Length[list]}];
(*Random choice of a instrument*)
sub = list[[random]];
list = Delete[list,random];
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
			Button["Submit",
				If[userAnswerName == name,
					answeredName = True; MessageDialog["Esatto!"],
					answeredName = True; MessageDialog["Sbagliato!"],
	                                 MessageDialog["Seleziona una risposta!"]
				]
			],
			Button["Next",
				If[answeredName == True,
					MakeNameQuiz[],
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


MakeTypeQuiz[] := Module[
{ list = $instrumentList,random = 0, sub = Null},
toChooseType = {"Fiato","Percussione","Tastiera","Corda"};
SeedRandom[];
random = RandomInteger[{1,Length[list]}];
(*Random choice of a instrument*)
sub = list[[random]];
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
			Button["Submit",
				If[userAnswerType == nameType,
					answeredType = True; MessageDialog["Esatto!"],
					answeredType = True; MessageDialog["Sbagliato!"],
	                                 MessageDialog["Seleziona una risposta!"]
				]
			],
			Button["Next",
				If[answeredType == True,
					MakeTypeQuiz[],
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

MakeSoundQuiz[] := DynamicModule[
{list = $instrumentSoundList,random = 0, sub = Null},
toChooseSound = {"Pianoforte","Sassofono","Chitarra","Violoncello", "Tromba"};
SeedRandom[];
random = RandomInteger[{1,Length[list]}];
(*Random choice of a instrument*)
sub = list[[random]];
answerSound = sub[[2]];
instrument = sub[[1]];
choosenSound = "";
answeredSound = False;
panel = Panel[
Row[{
Column[{
Dynamic[
Sound[{
SoundNote["E4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["A4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["F4", 0.25, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["F4", 0.25, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["F4", 0.25, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["F4", 0.25, instrument],
SoundNote["A4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote["C4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote["C4", 0.25, instrument],
SoundNote["B4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["C4", 0.25, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["A4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["F4", 0.25, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["F4", 0.25, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["F4", 0.25, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["F4", 0.25, instrument],
SoundNote["A4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote["C4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote["C4", 0.25, instrument],
SoundNote["B4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["C4", 0.25, instrument],
SoundNote["B4", 0.25, instrument],
SoundNote["C4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote["C4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote["C4", 0.25, instrument],
SoundNote["B4", 0.25, instrument],
SoundNote["A4", 0.25, instrument],
SoundNote["F4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["E4", 0.50, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["F4", 0.25, instrument],
SoundNote["E4", 0.25, instrument],
SoundNote["D4", 0.25, instrument],
SoundNote[None, 0.50, instrument],
SoundNote["E4", 1, instrument]
}]
]
}],
Spacer[225 0.7],
Column[{
Row[{Dynamic[RadioButtonBar[Dynamic[choosenSound],toChooseSound,Appearance->"Vertical"]]}],
Row[{
Button["Submit",
If[choosenSound == answerSound,
answeredSound = True; MessageDialog["Esatto!"],
MessageDialog["Sbagliato!"],
MessageDialog["Seleziona una risposta!"]
]
]
}],
Row[{
Button["Next",
If[answeredSound == True,
					MakeSoundQuiz[],
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
