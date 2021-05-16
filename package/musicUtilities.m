(* ::Package:: *)

(* :Title:MusicPlayUtilities*)
(* :Context:MusicPlayUtilities`*)
(* :Author:VT*)
(* :Summary:music play utilities*)
(* :Copyright:*)
(* :Package Version:1,Maggio 2020*)
(* :Mathematica Version:11.2*)
(* :History:*)
(* :Sources:*)
(* :Limitations:*)
(* :Discussion:*)


BeginPackage["MusicPlayUtilities`"];

$pathPlay = StringReplace[NotebookDirectory[],"package\\" -> ""];
Needs["MusicScore`",$pathPlay <>"package/print_music_score.m"];
Needs["MusicUtilities`",$pathPlay <>"package/utilities.m"];
Needs["IntervalTheoryAndExercises`",$pathPlay <>"package/intervals.m"];
simpleScale = {"C4","D4","E4","F4","G4","A4","B4"};
instruments = {"Pianoforte", "Sassofono", "Chitarra", "Violoncello", "Tromba"};
images = {Import[$pathPlay <>"immagini/pianoforte.jpg"],  Import[$pathPlay <>"immagini/sassofono.jpg"], Import[$pathPlay <> "immagini/chitarra.jpg"], Import[$pathPlay <> "immagini/violoncello.jpg"], Import[$pathPlay <> "immagini/tromba.jpg"]};
captions = {"Il pianoforte \[EGrave] uno strumento musicale a corde percosse mediante martelletti, azionati da una tastiera. L'origine del termine \[EGrave] italiana ed \[EGrave] riferito alla possibilit\[AGrave] di suonare note a volumi diversi in base al tocco, effetto non ottenibile in strumenti a tastiera precedenti, quali il clavicembalo.

La tastiera \[EGrave] di norma composta da 88 tasti, 52 bianchi e 36 neri. I bianchi rappresentano le note: do, re, mi, fa, sol, la e si. I neri individuano generalmente le alterazioni (note bemolli o diesis). Il pianoforte \[EGrave] il pi\[UGrave] diffuso strumento appartenente ai cordofoni a corde percosse; altri membri sono il clavicordo, oggi utilizzato prevalentemente per l'esecuzione filologica della musica d'epoca, e il fortepiano, progenitore del pianoforte.

Il suono pu\[OGrave] essere modificato anche mediante pedali (solitamente tre), che azionano particolari meccanismi. In un moderno pianoforte a coda troviamo, da sinistra a destra, l'una corda, il tonale e quello di risonanza. Nei pianoforti verticali il pedale centrale aziona la sordina, che frappone una striscia di feltro fra le corde e i martelli per attutire il suono. Solo il primo e il terzo pedale sono presenti su tutti i pianoforti.", "Il sassofono, saxofono, o, semplicemente, sax, \[EGrave] uno strumento musicale aerofono ad ancia semplice. Il sassofono fa parte della famiglia dei legni e non degli ottoni poich\[EAcute], sebbene il corpo dello strumento sia normalmente di metallo (spesso proprio di ottone), l'emissione del suono \[EGrave] provocata dalla vibrazione di un'ancia ricavata da canna comune (Arundo donax). La lunghezza della colonna d'aria vibrante, e quindi l'altezza del suono prodotto, viene modificata attraverso dei fori, controllati da chiavi, sul corpo dello strumento. Fu inventato da Adolphe Sax, da cui ha preso il nome, nel 1840 e brevettato il 22 giugno del 1846. Ha avuto una grandissima e veloce espansione in moltissimi generi musicali grazie alle sue doti di espressivit\[AGrave] e duttilit\[AGrave].

In generale la famiglia dei sax \[EGrave] presente in quasi tutti i generi musicali moderni, anche se meno nella musica elettronica in generale. La tendenza verso la musica sintetica e campionata ha solo scalfito la sua popolarit\[AGrave]. A causa della sua recente invenzione, nella musica classica il sassofono \[EGrave] un po' penalizzato dalla limitata letteratura, ma \[EGrave] tuttavia presente, anche con ruoli di rilievo, nelle orchestre sinfoniche: si ricordi l'assolo per sax alto in Il Vecchio Castello dai Quadri di un'esposizione di Mussorgskij orchestrati da Maurice Ravel nel 1922. Inoltre esiste un crescente corpus di musica cameristica originale per sassofoni, spesso in quartetto, e di trascrizioni. Dotato di una voce potente e di grande proiezione di suono, il sassofono ha un vasto uso bandistico, ad esempio \[EGrave] molto impiegato nelle bande militari statunitensi, e per questo motivo fu quasi subito presente nelle prime formazioni jazz, un genere musicale di cui \[EGrave] diventato il simbolo internazionale.","Le tre corde pi\[UGrave] sottili sono in plastica; le tre pi\[UGrave] grosse sono di nylon rivestito di metallo, o talvolta di seta rivestita di metallo. In passato, le corde erano di budello di agnello. L'amplificazione \[EGrave] ottenuta per risonanza dal corpo vuoto a forma di otto (la cassa armonica), mentre la tavola superiore \[EGrave] responsabile dello spostamento d'aria. Il cavigliere (o paletta) \[EGrave] leggermente inclinato all'indietro. Secondo la posizione tradizionale usata per la musica classica, questo tipo di chitarra si suona da seduti, con le dita, poggiando lo strumento sulla gamba sinistra, leggermente rialzata tramite un apposito poggiapiede.

Si possono anche trovare chitarre classiche a spalla mancante per facilitare lo spostamento nelle zone pi\[UGrave] alte della tastiera, e amplificate. Le chitarre flamenco sono molto simili per costruzione; hanno una protezione di plastica trasparente sopra e sotto la buca (detta golpero) per garantire l'integrit\[AGrave] del sottile legno della tavola armonica dai colpi con le dita caratteristici di questo stile (vedi golpe e rasgueado).", "Il violoncello \[EGrave] uno strumento musicale del gruppo dei cordofoni a corde sfregate (ad arco), appartenente alla famiglia degli archi; \[EGrave] dotato di quattro corde, accordate ad intervalli di quinta giusta. Presentano dei tagli ad \"effe\" sulla tavola armonica (o piano armonico).

La sottofamiglia dei \"violini\" si differenzia cos\[IGrave] dalla sottofamiglia delle \"viole\" che comprende invece la viola da gamba e altri strumenti antichi con tagli a \"C\", accordati per quarte e terze, con corde in numero variabile da tre, a sei-sette o pi\[UGrave]. Si suona da seduti tenendo lo strumento tra le gambe, poggiato su un puntale presente nella parte inferiore dello strumento. L'esecutore conduce l'arco trasversalmente sulle corde.

Il violoncello moderno possiede quattro corde accordate ad intervalli di quinta giusta: la corda del La (cantino), del Re, del Sol e del Do. La corda del La emette un suono tre semitoni pi\[UGrave] in basso del Do centrale e la corda del Do \[EGrave] due ottave pi\[UGrave] basse del Do centrale. L'accordatura dello strumento \[EGrave] dunque una ottava sotto a quella della viola.

Il violoncello \[EGrave] strettamente associato alla musica classica, \[EGrave] parte dell'orchestra d'archi e dell'orchestra sinfonica, del quartetto d'archi e di molte altre formazioni di musica da camera. Molti sono i concerti e le sonate scritte per violoncello. Viene usato in minor misura anche nella musica leggera, nel rock, heavy metal, e meno comunemente nella musica popolare.", "La tromba \[EGrave] uno strumento antichissimo, se ne trovano testimonianze in varie epoche e culture dove, seppure costruita in vari materiali, la tecnica di base per suonarla era sempre la stessa: utilizzare le labbra per creare delle vibrazioni nella colonna d\[CloseCurlyQuote]aria.
Probabilmente per il suono squillante, anche il suo utilizzo era simile un po\[CloseCurlyQuote]ovunque: spesso la tromba funge da segnale, un modo per portare un messaggio o un ordine da una persona ad altre persone a grande distanza fra loro; per comunicare: gli allevatori europei usano i corni delle Alpi per chiamarsi attraverso le montagne; dalle legioni Romane alla Cavalleria degli Stati Uniti le trombe sono state una parte essenziale della vita militare.

La tromba che conosciamo oggi \[EGrave] uno strumento costruito in ottone (per questo motivo fa parte della famiglia degli ottoni), con un tubo avvolto e aperto alla fine in una campana, un bocchino separato e tre pistoni che, premuti dal suonatore, modificano il percorso dell'aria alterandone la lunghezza. Con solo tre pistoni si possono suonare tutte le note! La sua estensione \[EGrave] di circa due ottave e mezzo ma il limite non \[EGrave] dato tanto dallo strumento quanto dal trombettista.

Ci sono trombe costruite in varie tonalit\[AGrave] (cio\[EGrave] con la nota base di partenza della scala differente), quella pi\[UGrave] usata \[EGrave] la TROMBA in SI bemolle, seguita da quella in DO."};



showNotes::usage="showNotes []
Show a simple music score with notes in noteList and play that with button to navigate in notesList.";
instrumentDescription::usage="instrumentDescription []
Display information about some instrument";



Begin["`Private`"];


instrumentDescription[]:= DynamicModule[
{listIn = instruments, listIm = images, label = "Pianoforte",listCaption = captions},
Panel[Column[{
Row[{Spacer[200 2.3], SetterBar[Dynamic[label], listIn]}],
Spacer[100 0.5],
Row[{
	Dynamic[
	Labeled[
	ImageResize[listIm[[First[First[Position[listIn,label]]]]], 500],
	 {Text[Style[listCaption[[First[First[Position[listIn,label]]]]], FontFamily-> "Arial", FontSize->16, LineSpacing->{2, 0}, LineIndent-> 0]] }   
	 , {Right}]
	 ]
	 }]
}]
,FrameMargins-> 50]
]

showNotes[]:= DynamicModule[
{list = simpleScale,  prevLabel = "--", nextLabel = "--",instrument = "SteelGuitar"},
spartitoList = createSpartitoList[list];
spartito = PrintPart[spartitoList];
noteInd = 1;
labelList = {};
euList = {};
usList = {};
euList = toLabelList[list,{},"e"];
usList = list;
labelList = euList;
labelList = removeBrackets[labelList];
nextLabel = Dynamic[labelList[[noteInd+1]]];
panel = Panel[Row[
{
Spacer[72 0.7],Column[{
Row[{

Button[Dynamic[prevLabel], 

If[noteInd > 2,
nextLabel =labelList[[noteInd]];
EmitSound[Sound[SoundNote[list[[noteInd-1]],1,instrument ]]];noteInd-= 1; prevLabel = Dynamic[labelList[[noteInd-1]]],
	If[noteInd > 1,
		nextLabel = Dynamic[labelList[[noteInd+1]]];noteInd-= 1; EmitSound[Sound[SoundNote[list[[noteInd]],1,instrument ]]];   prevLabel = "--"
	]
]
],
Spacer[174 0.7],
Style[Dynamic[  labelList[[noteInd]]]  ,FontFamily->"Arial-Bold",14],
Spacer[174 0.7],

Button[Dynamic[nextLabel],
If[ noteInd < Length[list] -1 ,
prevLabel = labelList[[noteInd]];noteInd+=1;
EmitSound[Sound[SoundNote[list[[noteInd]],1,instrument ]]];
nextLabel = Dynamic[labelList[[noteInd +1]]],

If[noteInd < Length[list],
prevLabel = Dynamic[labelList[[noteInd-1]]];noteInd+=1; EmitSound[Sound[SoundNote[list[[noteInd]],1,instrument ]]]; nextLabel = "--"
]
]
]

}],
Spacer[87  0.7],
Row[{Magnify[Dynamic[spartito],4]}]
}],

Spacer[87  0.7],


Column[{
PopupMenu[Dynamic[instrument],{"SteelGuitar","Banjo","Contrabass","Oboe","Piano","SopranoSax","Clarinet"}],
Spacer[87 0.7],

Button["Play",EmitSound[Sound[SoundNote[list[[noteInd]],1,instrument ]]]],
    Spacer[50 0.7],

RadioButtonBar[Dynamic[labelList],{removeBrackets[euList]->"EU notes",removeBrackets[usList]->"US notes"}] 

}] 


}],ImageSize->700]
]

End[];
EndPackage[]

