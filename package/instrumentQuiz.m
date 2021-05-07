(* ::Package:: *)

(* ::Input:: *)
(*(* :Title:InstrumentQuiz*)*)
(*(* :Context:InstrumentQuiz`*)*)
(*(* :Author:VT*)*)
(*(* :Summary:instrument quiz package*)*)
(*(* :Copyright:*)*)
(*(* :Package Version:1,Maggio 2020*)*)
(*(* :Mathematica Version:11.2*)*)
(*(* :History:*)*)
(*(* :Sources:*)*)
(*(* :Limitations:*)(* :Discussion:*)*)


(* ::Input:: *)
(*BeginPackage["InstrumentQuiz`"];*)
(**)
(*MakeInstrumentQuiz::usage="MakeInstrumentQuiz []*)
(*Create some random exercise  with instrument, check name, type and sound of an instrument."*)
(**)
(*$instrumentList::usage="$instrumentList*)
(*Is the global luist of instrument."*)
(**)
(*$instrumentList = { *)
(*{"Batteria","Percussione"},*)
(*{"Clarinetto","Fiato"},*)
(*{"Piano","Tastiera"},*)
(*{"Pianola","Tastiera"},*)
(*{"Sassofono soprano","Fiato"},*)
(*{"Tamburo","Percussione"},*)
(*{"Viola","Corda"} ,*)
(*{"Violino","Corda"},*)
(*{"Violoncello","Corda"}*)
(*   *)
(*};*)
(**)
(*For[i = 1, i <= Length[$instrumentList],i++,*)
(*sub = $instrumentList[[i]];*)
(*pic = Import["immagini/strumenti/"<>sub[[1]]<>".jpg"];*)
(*$instrumentList[[i]] = Append[$instrumentList[[i]],pic];*)
(*]*)


(* ::Input:: *)
(*Begin["`Private`"];*)
(**)
(*MakeInstrumentQuiz[] := Module[*)
(*{random = 0,ret = Null},*)
(*SeedRandom[];*)
(*random = RandomInteger[{1,300}];*)
(**)
(*If[random <= 100,*)
(*ret  = MakeNameQuiz[],*)
(*If[random > 100 && random <= 200,*)
(*ret  = MakeTypeQuiz[],*)
(*ret  = MakeSoundQuiz[]*)
(*]*)
(*];*)
(**)
(*Return[ret];*)
(*]*)
(**)
(**)
(*MakeNameQuiz[] := Module[*)
(*{ list = $instrumentList,random = 0, sub = Null},*)
(**)
(*SeedRandom[];*)
(*random = RandomInteger[{1,Length[list]}];*)
(*Print["RANDOM@ ",random];*)
(*(*Random choice of a instrument*)*)
(*sub = list[[random]];*)
(*picture = sub[[3]];*)
(*name = sub[[1]];*)
(*choosen = "";*)
(*toChoose = {}; (*Random list of instrument name*)*)
(*rand = seed;*)
(*For[answer = 1, answer <= 3,answer++,*)
(*SeedRandom[];*)
(*rand = RandomInteger[{1,Length[list]}];*)
(*If[rand != random && !MemberQ[toChoose,list[[rand]]], *)
(*elem =list[[rand]];*)
(* toChoose = Append[toChoose,elem[[1]]],*)
(**)
(*answer--;*)
(* ];*)
(*];*)
(*newPos = RandomInteger[{1,3}];*)
(*toChoose = Insert[toChoose,name,newPos];*)
(*panel = Panel[*)
(*Row[{*)
(*Column[{*)
(*Magnify[Dynamic[picture],4.5]*)
(*}],*)
(*Spacer[225 0.7],*)
(*Column[{*)
(*Row[{Dynamic[RadioButtonBar[Dynamic[choosen],toChoose,Appearance->"Vertical"]]}],*)
(*Row[{*)
(*Button["Submit",*)
(*If[choosen == name,*)
(*MessageDialog["You nailed it!"],*)
(*MessageDialog["Wrong answer!"]*)
(*]*)
(*]*)
(*}],*)
(*Row[{*)
(*Button["Next",*)
(*MakeInstrumentQuiz[];*)
(*]*)
(*}]*)
(*}],*)
(*Spacer[15 0.7]*)
(*}]*)
(*,ImageSize->700];*)
(*Return[panel];*)
(**)
(*]*)
(**)
(**)
(*MakeTypeQuiz[] := Module[*)
(*{ list = $instrumentList,random = 0, sub = Null},*)
(*toChoose = {"Fiato","Percussione","Tastiera","Corda"};*)
(*SeedRandom[];*)
(*random = RandomInteger[{1,Length[list]}];*)
(*Print["RANDOM@ ",random];*)
(*(*Random choice of a instrument*)*)
(*sub = list[[random]];*)
(*picture = sub[[3]];*)
(*name = sub[[2]];*)
(*choosen = "";*)
(*newPos = RandomInteger[{1,3}];*)
(*panel = Panel[*)
(*Row[{*)
(*Column[{*)
(*Magnify[Dynamic[picture],4.5]*)
(*}],*)
(*Spacer[225 0.7],*)
(*Column[{*)
(*Row[{Dynamic[RadioButtonBar[Dynamic[choosen],toChoose,Appearance->"Vertical"]]}],*)
(*Row[{*)
(*Button["Submit",*)
(*If[choosen == name,*)
(*MessageDialog["You nailed it!"],*)
(*MessageDialog["Wrong answer!"]*)
(*]*)
(*]*)
(*}],*)
(*Row[{*)
(*Button["Next",*)
(*MakeInstrumentQuiz[];*)
(*]*)
(*}]*)
(*}],*)
(*Spacer[15 0.7]*)
(*}]*)
(*,ImageSize->700];*)
(*Return[panel];*)
(**)
(*]*)
(**)
(**)
(**)
(**)
(*End[]*)
(*EndPackage[]*)


 