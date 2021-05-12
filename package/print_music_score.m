(* Content-type: application/vnd.wolfram.mathematica *)

(*** Wolfram Notebook File ***)
(* http://www.wolfram.com/nb *)

(* CreatedBy='Mathematica 11.2' *)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[       158,          7]
NotebookDataLength[     29925,        741]
NotebookOptionsPosition[     29181,        721]
NotebookOutlinePosition[     29559,        737]
CellTagsIndexPosition[     29516,        734]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", 
   RowBox[{":", "Title", ":", "MusicScore"}], "*)"}], "\n", 
  RowBox[{"(*", " ", 
   RowBox[{":", "Context", ":", "MusicScore`"}], "*)"}], "\n", 
  RowBox[{"(*", " ", 
   RowBox[{":", "Author", ":", "VT"}], "*)"}], "\n", 
  RowBox[{"(*", " ", 
   RowBox[{":", "Summary", ":", 
    RowBox[{"music", " ", "score", " ", "creator"}]}], "*)"}], "\n", 
  RowBox[{"(*", " ", 
   RowBox[{":", "Copyright", ":"}], "*)"}], "\n", 
  RowBox[{"(*", " ", 
   RowBox[{
    RowBox[{":", 
     RowBox[{"Package", " ", "Version"}], ":", "1"}], ",", 
    RowBox[{"Maggio", " ", "2020"}]}], "*)"}], "\n", 
  RowBox[{"(*", " ", 
   RowBox[{":", 
    RowBox[{"Mathematica", " ", "Version"}], ":", "11.2"}], "*)"}], "\n", 
  RowBox[{"(*", " ", 
   RowBox[{":", "History", ":"}], "*)"}], "\n", 
  RowBox[{"(*", " ", 
   RowBox[{":", "Sources", ":"}], "*)"}], "\n", 
  RowBox[{"(*", " ", 
   RowBox[{":", "Limitations", ":"}], "*)"}], 
  RowBox[{"(*", " ", 
   RowBox[{":", "Discussion", ":"}], "*)"}], "\[IndentingNewLine]", 
  "\[IndentingNewLine]", "\[IndentingNewLine]", "\[IndentingNewLine]", 
  RowBox[{
   RowBox[{
    RowBox[{"BeginPackage", "[", "\"\<MusicScore`\>\"", "]"}], ";"}], "\n", 
   "\[IndentingNewLine]", 
   RowBox[{"(*", 
    RowBox[{
     RowBox[{"SetDirectory", "[", 
      RowBox[{"StringReplace", "[", 
       RowBox[{
        RowBox[{"NotebookDirectory", "[", "]"}], ",", 
        RowBox[{"\"\<package\\\\\>\"", " ", "->", " ", "\"\<\>\""}]}], "]"}], 
      "]"}], ";"}], "*)"}], "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintPart", "::", "usage"}], "=", 
     "\"\<PrintPart [notesList_]\nCreate a music score from list notes in \
noteList, they have to be sub list with a number next to note e.g. \
{{notes..},{notes..}}.\>\""}], " ", ";"}], "\[IndentingNewLine]", 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"$path", " ", "=", " ", 
     RowBox[{"StringReplace", "[", 
      RowBox[{
       RowBox[{"NotebookDirectory", "[", "]"}], ",", 
       RowBox[{"\"\<package\\\\\>\"", " ", "->", " ", "\"\<\>\""}]}], "]"}]}],
     ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"$chiave", " ", "=", " ", 
     RowBox[{"Import", "[", 
      RowBox[{"$path", " ", "<>", "\"\<immagini\\\\chiave.png\>\""}], "]"}]}],
     ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"$note", " ", "=", " ", 
     RowBox[{"Import", "[", 
      RowBox[{
      "$path", " ", "<>", "\"\<immagini\\\\nota_senza_barra.png\>\""}], 
      "]"}]}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"$notebarra", " ", "=", " ", 
     RowBox[{"Import", "[", 
      RowBox[{"$path", " ", "<>", "\"\<immagini\\\\nota_barra.png\>\""}], 
      "]"}]}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"$barra", " ", "=", " ", 
     RowBox[{"Import", "[", 
      RowBox[{"$path", " ", "<>", "\"\<immagini\\\\barra.png\>\""}], "]"}]}], 
    ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"$blank", " ", "=", " ", 
     RowBox[{"Import", "[", 
      RowBox[{"$path", " ", "<>", "\"\<immagini\\\\blank.png\>\""}], "]"}]}], 
    ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"$diesis", " ", "=", " ", 
     RowBox[{"Import", "[", 
      RowBox[{"$path", " ", "<>", "\"\<immagini\\\\diesis.png\>\""}], "]"}]}],
     ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"$bemolle", " ", "=", 
     RowBox[{"Import", "[", 
      RowBox[{"$path", " ", "<>", "\"\<immagini\\\\bemolle.png\>\""}], 
      "]"}]}], ";"}], "\[IndentingNewLine]", "\n", 
   RowBox[{
    RowBox[{"$AmNatList", "=", 
     RowBox[{"{", 
      RowBox[{
      "\"\<C\>\"", ",", "\"\<D\>\"", ",", "\"\<E\>\"", ",", " ", "\"\<F\>\"", 
       ",", "\"\<G\>\"", ",", " ", "\"\<A\>\"", ",", "\"\<B\>\""}], "}"}]}], 
    ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"$AmSharpList", " ", "=", 
     RowBox[{"{", 
      RowBox[{
      "\"\<C\>\"", ",", "\"\<C#\>\"", ",", " ", "\"\<D\>\"", ",", " ", 
       "\"\<D#\>\"", ",", "  ", "\"\<E\>\"", ",", " ", "\"\<F\>\"", ",", " ", 
       "\"\<F#\>\"", ",", " ", "\"\<G\>\"", ",", " ", "\"\<G#\>\"", ",", 
       "  ", "\"\<A\>\"", ",", " ", "\"\<A#\>\"", ",", "  ", "\"\<B\>\""}], 
      "}"}]}], ";"}], "\[IndentingNewLine]", "\n", 
   RowBox[{
    RowBox[{"Begin", "[", "\"\<`Private`\>\"", "]"}], ";"}], 
   "\[IndentingNewLine]", "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"Sharpize", "[", "n_", "]"}], ":=", "n"}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"Sharpize", "[", 
      RowBox[{"n_", "/;", " ", 
       RowBox[{
        RowBox[{"StringTake", "[", 
         RowBox[{"n", ",", " ", 
          RowBox[{"-", "1"}]}], "]"}], "\[Equal]", "\"\<b\>\""}]}], "]"}], 
     " ", ":=", " ", 
     RowBox[{"StringJoin", "[", 
      RowBox[{
       RowBox[{"$AmNatList", "[", 
        RowBox[{"[", 
         RowBox[{
          RowBox[{"Mod", "[", 
           RowBox[{
            RowBox[{
             RowBox[{
              RowBox[{
               RowBox[{"Position", "[", 
                RowBox[{"$AmNatList", ",", " ", 
                 RowBox[{"StringTake", "[", 
                  RowBox[{"n", ",", " ", "1"}], "]"}]}], "]"}], "[", 
               RowBox[{"[", "1", "]"}], "]"}], "[", 
              RowBox[{"[", "1", "]"}], "]"}], "+", "5"}], ",", " ", "7"}], 
           "]"}], "+", "1"}], "]"}], "]"}], ",", " ", "\"\<#\>\""}], "]"}]}], 
    ";"}], "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"NoteImg", "[", 
      RowBox[{
       RowBox[{"n_", "/;", " ", 
        RowBox[{
         RowBox[{"!", 
          RowBox[{"StringContainsQ", "[", 
           RowBox[{"n", ",", "\"\<#\>\""}], "]"}]}], " ", "&&", " ", 
         RowBox[{"!", 
          RowBox[{"StringContainsQ", "[", 
           RowBox[{"n", ",", "\"\<b\>\""}], "]"}]}]}]}], ",", " ", 
       RowBox[{"img_", " ", ":", "$note"}]}], "]"}], ":=", 
     RowBox[{"ImageCompose", "[", 
      RowBox[{"$blank", ",", " ", "img", ",", " ", 
       RowBox[{"{", 
        RowBox[{"119", ",", " ", "84.5"}], "}"}]}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"NoteImg", "[", 
      RowBox[{
       RowBox[{"n_", "/;", 
        RowBox[{"StringContainsQ", "[", 
         RowBox[{"n", ",", " ", "\"\<#\>\""}], "]"}]}], " ", ",", " ", 
       RowBox[{"img_", " ", ":", "$note"}]}], "]"}], " ", ":=", " ", 
     RowBox[{"ImageCompose", "[", 
      RowBox[{
       RowBox[{"ImageCompose", "[", 
        RowBox[{"$blank", ",", " ", "$note", ",", " ", 
         RowBox[{"{", 
          RowBox[{"119", ",", " ", "84.5"}], "}"}]}], "]"}], ",", " ", 
       "$diesis", ",", " ", 
       RowBox[{"{", 
        RowBox[{"70", ",", " ", "83"}], "}"}]}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"NoteImg", "[", 
      RowBox[{
       RowBox[{"n_", "/;", 
        RowBox[{"StringContainsQ", "[", 
         RowBox[{"n", ",", " ", "\"\<b\>\""}], "]"}]}], " ", ",", " ", 
       RowBox[{"img_", " ", ":", "$note"}]}], "]"}], " ", ":=", " ", 
     RowBox[{"ImageCompose", "[", 
      RowBox[{
       RowBox[{"ImageCompose", "[", 
        RowBox[{"$blank", ",", " ", "$note", ",", " ", 
         RowBox[{"{", 
          RowBox[{"119", ",", " ", "84.5"}], "}"}]}], "]"}], ",", " ", 
       "$bemolle", ",", " ", 
       RowBox[{"{", 
        RowBox[{"70", ",", " ", "100"}], "}"}]}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"NoteDistance", "[", 
      RowBox[{"a_", ",", " ", 
       RowBox[{"b_:", "\"\<C4\>\""}]}], "]"}], " ", ":=", " ", 
     RowBox[{
      RowBox[{"12", 
       RowBox[{"FromDigits", "[", 
        RowBox[{"StringTake", "[", 
         RowBox[{"a", ",", " ", 
          RowBox[{"-", "1"}]}], "]"}], "]"}]}], "-", " ", 
      RowBox[{"12", 
       RowBox[{"FromDigits", "[", 
        RowBox[{"StringTake", "[", 
         RowBox[{"b", ",", " ", 
          RowBox[{"-", "1"}]}], "]"}], "]"}]}], " ", "+", 
      RowBox[{
       RowBox[{
        RowBox[{"Position", "[", 
         RowBox[{"$AmSharpList", ",", " ", 
          RowBox[{"Sharpize", "[", 
           RowBox[{"StringTake", "[", 
            RowBox[{"a", ",", " ", 
             RowBox[{"{", 
              RowBox[{"1", ",", 
               RowBox[{"-", "2"}]}], "}"}]}], "]"}], "]"}]}], "]"}], "[", 
        RowBox[{"[", "1", "]"}], "]"}], "[", 
       RowBox[{"[", "1", "]"}], "]"}], "-", " ", 
      RowBox[{
       RowBox[{
        RowBox[{"Position", "[", 
         RowBox[{"$AmSharpList", ",", 
          RowBox[{"Sharpize", "[", 
           RowBox[{"StringTake", "[", 
            RowBox[{"b", ",", " ", 
             RowBox[{"{", 
              RowBox[{"1", ",", 
               RowBox[{"-", "2"}]}], "}"}]}], "]"}], "]"}]}], "]"}], "[", 
        RowBox[{"[", "1", "]"}], "]"}], "[", 
       RowBox[{"[", "1", "]"}], "]"}]}]}], ";"}], "\[IndentingNewLine]", 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"NoteSpaces", "[", 
      RowBox[{"a_", ",", " ", 
       RowBox[{"b_:", "\"\<C4\>\""}]}], "]"}], " ", ":=", " ", 
     RowBox[{
      RowBox[{"7", 
       RowBox[{"FromDigits", "[", 
        RowBox[{"StringTake", "[", 
         RowBox[{"a", ",", " ", 
          RowBox[{"-", "1"}]}], "]"}], "]"}]}], "-", " ", 
      RowBox[{"7", 
       RowBox[{"FromDigits", "[", 
        RowBox[{"StringTake", "[", 
         RowBox[{"b", ",", " ", 
          RowBox[{"-", "1"}]}], "]"}], "]"}]}], " ", "+", 
      RowBox[{
       RowBox[{
        RowBox[{"Position", "[", 
         RowBox[{"$AmNatList", ",", " ", 
          RowBox[{"StringTake", "[", 
           RowBox[{"a", ",", " ", "1"}], "]"}]}], "]"}], "[", 
        RowBox[{"[", "1", "]"}], "]"}], "[", 
       RowBox[{"[", "1", "]"}], "]"}], "-", " ", 
      RowBox[{
       RowBox[{
        RowBox[{"Position", "[", 
         RowBox[{"$AmNatList", ",", " ", 
          RowBox[{"StringTake", "[", 
           RowBox[{"b", ",", " ", "1"}], "]"}]}], "]"}], "[", 
        RowBox[{"[", "1", "]"}], "]"}], "[", 
       RowBox[{"[", "1", "]"}], "]"}]}]}], ";"}], "\[IndentingNewLine]", 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"NotePreorderQ", "[", 
      RowBox[{"a_", ",", " ", 
       RowBox[{"b_:", "\"\<C4\>\""}]}], "]"}], " ", ":=", " ", 
     RowBox[{
      RowBox[{"NoteDistance", "[", 
       RowBox[{"a", ",", " ", "b"}], "]"}], "\[LessEqual]", "0"}]}], ";"}], 
   "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"NoteSpacesPreorderQ", "[", 
      RowBox[{"a_", ",", " ", 
       RowBox[{"b_:", "\"\<C4\>\""}]}], "]"}], " ", ":=", " ", 
     RowBox[{
      RowBox[{"NoteSpaces", "[", 
       RowBox[{"a", ",", " ", "b"}], "]"}], "\[LessEqual]", "0"}]}], ";"}], 
   "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintNote", "[", 
      RowBox[{"o_", ",", " ", 
       RowBox[{"n_", "/;", 
        RowBox[{
         RowBox[{"NotePreorderQ", "[", 
          RowBox[{"n", ",", " ", "\"\<G5\>\""}], "]"}], "&&", " ", 
         RowBox[{"!", 
          RowBox[{"NotePreorderQ", "[", 
           RowBox[{"n", ",", "\"\<C4\>\""}], "]"}]}]}]}], ",", " ", 
       RowBox[{"back_:", "$chiave"}]}], "]"}], ":=", 
     RowBox[{"ImageCompose", "[", 
      RowBox[{"back", ",", " ", 
       RowBox[{"NoteImg", "[", 
        RowBox[{"n", ",", "$note"}], "]"}], ",", "  ", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"300", "+", 
          RowBox[{"150", "*", "o"}]}], ",", 
         RowBox[{"372", "+", 
          RowBox[{"13.2", "*", 
           RowBox[{"NoteSpaces", "[", 
            RowBox[{"n", ",", " ", "\"\<D4\>\""}], "]"}]}]}]}], " ", "}"}]}], 
      "]"}]}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintNote", "[", " ", 
      RowBox[{"o_", ",", " ", 
       RowBox[{"n_", "/;", 
        RowBox[{
         RowBox[{"NotePreorderQ", "[", 
          RowBox[{"n", ",", " ", "\"\<B3\>\""}], "]"}], "&&", " ", 
         RowBox[{"!", 
          RowBox[{"NotePreorderQ", "[", 
           RowBox[{"n", ",", "\"\<E2\>\""}], "]"}]}]}]}], ",", " ", 
       RowBox[{"back_:", "$chiave"}]}], "]"}], ":=", 
     RowBox[{"ImageCompose", "[", 
      RowBox[{"back", ",", " ", 
       RowBox[{"NoteImg", "[", 
        RowBox[{"n", ",", "$note"}], "]"}], ",", " ", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"300", "+", 
          RowBox[{"150", "*", "o"}]}], ",", 
         RowBox[{"104", "+", 
          RowBox[{"13.2", "*", 
           RowBox[{"NoteSpaces", "[", 
            RowBox[{"n", ",", " ", "\"\<F2\>\""}], "]"}]}]}]}], " ", "}"}]}], 
      "]"}]}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintNote", "[", " ", 
      RowBox[{"o_", ",", " ", 
       RowBox[{"n_", "/;", 
        RowBox[{
         RowBox[{"NotePreorderQ", "[", 
          RowBox[{"n", ",", " ", "\"\<C4\>\""}], "]"}], "&&", " ", 
         RowBox[{"NotePreorderQ", "[", 
          RowBox[{"\"\<C4\>\"", ",", "n"}], "]"}]}]}], ",", " ", 
       RowBox[{"back_:", "$chiave"}]}], "]"}], ":=", 
     RowBox[{"ImageCompose", "[", 
      RowBox[{"back", ",", " ", 
       RowBox[{"NoteImg", "[", 
        RowBox[{"n", ",", "$notebarra"}], "]"}], ",", " ", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"300", "+", 
          RowBox[{"150", "*", "o"}]}], ",", "304"}], "}"}]}], "]"}]}], ";"}], 
   "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintNote", "[", 
      RowBox[{"o_", ",", " ", 
       RowBox[{"n_", "/;", 
        RowBox[{
         RowBox[{"NotePreorderQ", "[", 
          RowBox[{"\"\<Ab5\>\"", ",", " ", "n"}], "]"}], "&&", 
         RowBox[{
          RowBox[{"Mod", "[", 
           RowBox[{
            RowBox[{"NoteSpaces", "[", 
             RowBox[{"n", ",", " ", "\"\<G5\>\""}], "]"}], ",", " ", "2"}], 
           "]"}], "\[Equal]", "1"}]}]}], ",", " ", 
       RowBox[{"back_:", "$chiave"}]}], "]"}], ":=", 
     RowBox[{
      RowBox[{"FoldList", "[", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{
         RowBox[{"ImageCompose", "[", 
          RowBox[{"#1", ",", " ", "$barra", ",", "  ", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"320", "+", 
              RowBox[{"150", "*", "o"}]}], ",", 
             RowBox[{"473.8", "+", 
              RowBox[{"13.2", "*", "#2"}]}]}], " ", "}"}]}], "]"}], "&"}], 
        ",", "\[IndentingNewLine]", 
        RowBox[{"ImageCompose", "[", 
         RowBox[{"back", ",", " ", 
          RowBox[{"NoteImg", "[", 
           RowBox[{"n", ",", "$notebarra"}], "]"}], ",", "  ", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"300", "+", 
             RowBox[{"150", "*", "o"}]}], ",", 
            RowBox[{"372", "+", 
             RowBox[{"13.2", "*", 
              RowBox[{"NoteSpaces", "[", 
               RowBox[{"n", ",", " ", "\"\<D4\>\""}], "]"}]}]}]}], " ", 
           "}"}]}], "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Range", "[", 
         RowBox[{"2", ",", " ", 
          RowBox[{
           RowBox[{"NoteSpaces", "[", 
            RowBox[{"n", ",", " ", "\"\<F5\>\""}], "]"}], "-", "2"}], ",", 
          " ", "2"}], "]"}]}], "]"}], "[", 
      RowBox[{"[", 
       RowBox[{"-", "1"}], "]"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintNote", "[", 
      RowBox[{"o_", ",", " ", 
       RowBox[{"n_", "/;", 
        RowBox[{
         RowBox[{"NotePreorderQ", "[", 
          RowBox[{"\"\<Ab5\>\"", ",", " ", "n"}], "]"}], "&&", 
         RowBox[{
          RowBox[{"Mod", "[", 
           RowBox[{
            RowBox[{"NoteSpaces", "[", 
             RowBox[{"n", ",", " ", "\"\<G5\>\""}], "]"}], ",", " ", "2"}], 
           "]"}], "\[Equal]", "0"}]}]}], ",", " ", 
       RowBox[{"back_:", "$chiave"}]}], "]"}], ":=", 
     RowBox[{
      RowBox[{"FoldList", "[", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{
         RowBox[{"ImageCompose", "[", 
          RowBox[{"#1", ",", " ", "$barra", ",", "  ", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"320", "+", 
              RowBox[{"150", "*", "o"}]}], ",", 
             RowBox[{"473.8", "+", 
              RowBox[{"13.2", "*", "#2"}]}]}], " ", "}"}]}], "]"}], "&"}], 
        ",", "\[IndentingNewLine]", 
        RowBox[{"ImageCompose", "[", 
         RowBox[{"back", ",", " ", 
          RowBox[{"NoteImg", "[", 
           RowBox[{"n", ",", "$note"}], "]"}], ",", "  ", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"300", "+", 
             RowBox[{"150", "*", "o"}]}], ",", 
            RowBox[{"372", "+", 
             RowBox[{"13.2", "*", 
              RowBox[{"NoteSpaces", "[", 
               RowBox[{"n", ",", " ", "\"\<D4\>\""}], "]"}]}]}]}], " ", 
           "}"}]}], "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Range", "[", 
         RowBox[{"2", ",", " ", 
          RowBox[{"NoteSpaces", "[", 
           RowBox[{"n", ",", " ", "\"\<F5\>\""}], "]"}], ",", " ", "2"}], 
         "]"}]}], "]"}], "[", 
      RowBox[{"[", 
       RowBox[{"-", "1"}], "]"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintNote", "[", 
      RowBox[{"o_", ",", " ", 
       RowBox[{"n_", "/;", 
        RowBox[{
         RowBox[{"NotePreorderQ", "[", 
          RowBox[{"n", ",", " ", "\"\<Fb2\>\""}], "]"}], "&&", 
         RowBox[{
          RowBox[{"Mod", "[", 
           RowBox[{
            RowBox[{"NoteSpaces", "[", 
             RowBox[{"n", ",", " ", "\"\<F2\>\""}], "]"}], ",", " ", "2"}], 
           "]"}], "\[Equal]", "1"}]}]}], ",", " ", 
       RowBox[{"back_:", "$chiave"}]}], "]"}], ":=", 
     RowBox[{
      RowBox[{"FoldList", "[", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{
         RowBox[{"ImageCompose", "[", 
          RowBox[{"#1", ",", " ", "$barra", ",", "  ", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"320", "+", 
              RowBox[{"150", "*", "o"}]}], ",", 
             RowBox[{"87", "-", 
              RowBox[{"13.2", "*", 
               RowBox[{"(", 
                RowBox[{"#2", "-", "1"}], ")"}]}]}]}], " ", "}"}]}], "]"}], 
         "&"}], ",", "\[IndentingNewLine]", 
        RowBox[{"ImageCompose", "[", 
         RowBox[{"back", ",", " ", 
          RowBox[{"NoteImg", "[", 
           RowBox[{"n", ",", "$notebarra"}], "]"}], ",", "  ", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"300", "+", 
             RowBox[{"150", "*", "o"}]}], ",", 
            RowBox[{"104", "-", 
             RowBox[{"13.2", "*", 
              RowBox[{"NoteSpaces", "[", 
               RowBox[{"\"\<F2\>\"", ",", " ", "n"}], "]"}]}]}]}], " ", 
           "}"}]}], "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Range", "[", 
         RowBox[{"2", ",", " ", 
          RowBox[{"NoteSpaces", "[", 
           RowBox[{"\"\<F2\>\"", ",", " ", "n"}], "]"}], ",", " ", "2"}], 
         "]"}]}], "]"}], "[", 
      RowBox[{"[", 
       RowBox[{"-", "1"}], "]"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintNote", "[", 
      RowBox[{"o_", ",", " ", 
       RowBox[{"n_", "/;", 
        RowBox[{
         RowBox[{"NotePreorderQ", "[", 
          RowBox[{"n", ",", " ", "\"\<Fb2\>\""}], "]"}], "&&", 
         RowBox[{
          RowBox[{"Mod", "[", 
           RowBox[{
            RowBox[{"NoteSpaces", "[", 
             RowBox[{"n", ",", " ", "\"\<F2\>\""}], "]"}], ",", " ", "2"}], 
           "]"}], "\[Equal]", "0"}]}]}], ",", " ", 
       RowBox[{"back_:", "$chiave"}]}], "]"}], ":=", 
     RowBox[{
      RowBox[{"FoldList", "[", "\[IndentingNewLine]", 
       RowBox[{
        RowBox[{
         RowBox[{"ImageCompose", "[", 
          RowBox[{"#1", ",", " ", "$barra", ",", "  ", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"320", "+", 
              RowBox[{"150", "*", "o"}]}], ",", 
             RowBox[{"87", "-", 
              RowBox[{"13.2", "*", 
               RowBox[{"(", 
                RowBox[{"#2", "-", "1"}], ")"}]}]}]}], " ", "}"}]}], "]"}], 
         "&"}], ",", "\[IndentingNewLine]", 
        RowBox[{"ImageCompose", "[", 
         RowBox[{"back", ",", " ", 
          RowBox[{"NoteImg", "[", 
           RowBox[{"n", ",", "$note"}], "]"}], ",", "  ", 
          RowBox[{"{", 
           RowBox[{
            RowBox[{"300", "+", 
             RowBox[{"150", "*", "o"}]}], ",", 
            RowBox[{"104", "-", 
             RowBox[{"13.2", "*", 
              RowBox[{"NoteSpaces", "[", 
               RowBox[{"\"\<F2\>\"", ",", " ", "n"}], "]"}]}]}]}], " ", 
           "}"}]}], "]"}], ",", "\[IndentingNewLine]", 
        RowBox[{"Range", "[", 
         RowBox[{"2", ",", " ", 
          RowBox[{"NoteSpaces", "[", 
           RowBox[{"\"\<F2\>\"", ",", " ", "n"}], "]"}], ",", " ", "2"}], 
         "]"}]}], "]"}], "[", 
      RowBox[{"[", 
       RowBox[{"-", "1"}], "]"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
   "\[IndentingNewLine]", "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintChord", "[", 
      RowBox[{"o_", ",", " ", "c_", ",", " ", 
       RowBox[{"back_:", "$chiave"}]}], "]"}], " ", ":=", 
     RowBox[{"Fold", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"PrintNote", "[", 
         RowBox[{"o", ",", " ", "#2", ",", " ", "#1"}], "]"}], "&"}], ",", 
       " ", "back", ",", " ", "c"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintPartPre", "[", 
      RowBox[{"p_", ",", 
       RowBox[{"o_:", "0"}], ",", " ", 
       RowBox[{"back_:", "$chiave"}]}], "]"}], " ", ":=", " ", 
     RowBox[{"Fold", "[", 
      RowBox[{
       RowBox[{
        RowBox[{"{", 
         RowBox[{
          RowBox[{
           RowBox[{"#1", "[", 
            RowBox[{"[", "1", "]"}], "]"}], "+", "1"}], ",", " ", 
          RowBox[{"PrintChord", "[", 
           RowBox[{
            RowBox[{"#1", "[", 
             RowBox[{"[", "1", "]"}], "]"}], ",", " ", "#2", ",", " ", 
            RowBox[{"#1", "[", 
             RowBox[{"[", "2", "]"}], "]"}]}], " ", "]"}]}], "}"}], "&"}], 
       ",", " ", 
       RowBox[{"{", " ", 
        RowBox[{"0", ",", " ", "back"}], "}"}], ",", " ", "p"}], "  ", 
      "]"}]}], ";"}], "\[IndentingNewLine]", "\[IndentingNewLine]", 
   "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{
     RowBox[{"PrintPart", "[", "p_", "]"}], " ", ":=", " ", 
     RowBox[{
      RowBox[{"PrintPartPre", "[", 
       RowBox[{"p", ",", " ", "0", ",", " ", "$chiave"}], "]"}], "[", 
      RowBox[{"[", "2", "]"}], "]"}]}], ";"}], "\[IndentingNewLine]", 
   "\[IndentingNewLine]", 
   RowBox[{"End", "[", "]"}], "\n", 
   RowBox[{"EndPackage", "[", "]"}], "\[IndentingNewLine]"}]}]], "Input",
 CellChangeTimes->{{3.8287613376108556`*^9, 3.828761581367326*^9}, {
   3.828763601284112*^9, 3.8287637290148687`*^9}, {3.8288721732897987`*^9, 
   3.828872365347783*^9}, {3.8288724095655003`*^9, 3.828872453001988*^9}, {
   3.828872607802105*^9, 3.8288727151286497`*^9}, {3.8288729365150366`*^9, 
   3.8288729705552692`*^9}, {3.828873002447916*^9, 3.8288730130086346`*^9}, {
   3.8288739007462482`*^9, 3.8288739008777633`*^9}, {3.8288750238269844`*^9, 
   3.8288750792594166`*^9}, {3.8288751158217936`*^9, 3.828875135316622*^9}, {
   3.8288751832760324`*^9, 3.828875322405738*^9}, {3.828875407360111*^9, 
   3.8288754096292677`*^9}, {3.828875631720467*^9, 3.8288757269908533`*^9}, {
   3.8288759921324663`*^9, 3.8288760215313416`*^9}, {3.828876085000202*^9, 
   3.8288762802558613`*^9}, {3.8288763103755536`*^9, 
   3.8288763555107517`*^9}, {3.8288763932513037`*^9, 
   3.8288763957748256`*^9}, {3.8288764260522285`*^9, 3.828876463023615*^9}, {
   3.828876636234584*^9, 3.828876646985119*^9}, {3.828876686068529*^9, 
   3.82887670579712*^9}, {3.828876782451161*^9, 3.8288767841142817`*^9}, {
   3.8288768324830956`*^9, 3.828876879677005*^9}, {3.828876926777794*^9, 
   3.828877168584674*^9}, {3.8288771995171485`*^9, 3.828877232734398*^9}, {
   3.8288772859791727`*^9, 3.8288772885883102`*^9}, {3.828877321303254*^9, 
   3.828877343192331*^9}, {3.828877375256183*^9, 3.8288773787329035`*^9}, {
   3.8288774462129993`*^9, 3.8288774650164995`*^9}, {3.8288775133477154`*^9, 
   3.8288775256255693`*^9}, {3.8288775933311443`*^9, 
   3.8288776713399305`*^9}, {3.8288777269877295`*^9, 
   3.8288778148903236`*^9}, {3.828877851316863*^9, 3.8288778939550686`*^9}, {
   3.828877938799413*^9, 3.8288779615130405`*^9}, {3.8288781508372684`*^9, 
   3.8288782621043234`*^9}, {3.8288783107000074`*^9, 
   3.8288783122509766`*^9}, {3.8288783667542963`*^9, 3.828878380675781*^9}, {
   3.828878442877598*^9, 3.828878537962474*^9}, {3.82887861059472*^9, 
   3.8288786284596295`*^9}, {3.8288787977480326`*^9, 3.828878824848653*^9}, {
   3.8290157955258408`*^9, 3.829015798471628*^9}, {3.829016510763348*^9, 
   3.8290165821346316`*^9}, {3.82901665491551*^9, 3.8290166579113245`*^9}, {
   3.829016862044411*^9, 3.829016879461274*^9}, {3.8290169592224565`*^9, 
   3.8290170414431343`*^9}, {3.8290170860173836`*^9, 
   3.8290170926950283`*^9}, {3.8290178754640245`*^9, 
   3.8290178914011116`*^9}, {3.8290179387897964`*^9, 3.829017962622425*^9}, {
   3.829018035100815*^9, 3.8290180704365697`*^9}, {3.8290182312082853`*^9, 
   3.829018289056245*^9}, {3.829018350417081*^9, 3.829018427374489*^9}, {
   3.829018551779794*^9, 3.829018594311161*^9}, 3.8290188164934263`*^9, {
   3.829020043444418*^9, 3.8290201286471853`*^9}, {3.829020163089225*^9, 
   3.829020185959078*^9}, {3.829020265690218*^9, 3.8290202899989457`*^9}, {
   3.8290203506038585`*^9, 3.8290203710096893`*^9}, {3.829020761444148*^9, 
   3.8290207624610696`*^9}, {3.8290209228657904`*^9, 
   3.8290209282138968`*^9}, {3.829021054244031*^9, 3.8290210568208714`*^9}, 
   3.829021163609376*^9, 3.829021329594307*^9, {3.829021435212*^9, 
   3.829021435622989*^9}, {3.8290224577871675`*^9, 3.829022640547867*^9}, {
   3.8290227153072453`*^9, 3.829022757779619*^9}, {3.8290228074955454`*^9, 
   3.829022808906474*^9}, {3.829022872358596*^9, 3.829023004697369*^9}, {
   3.829023036703374*^9, 3.8290230585440226`*^9}, {3.8290230967911267`*^9, 
   3.8290231705331707`*^9}, {3.8290233887076826`*^9, 3.829023475728593*^9}, {
   3.8290235164845095`*^9, 3.829023599556531*^9}, {3.8290237829873405`*^9, 
   3.8290237927754493`*^9}, {3.82902383534145*^9, 3.829023835750388*^9}, {
   3.829023943551119*^9, 3.8290239464379425`*^9}, {3.8290240021177034`*^9, 
   3.8290240260179543`*^9}, {3.8290242752008696`*^9, 3.829024299029225*^9}, {
   3.829625299092593*^9, 3.8296254908731303`*^9}, {3.829625551077401*^9, 
   3.8296257210676727`*^9}, {3.8296257557763042`*^9, 3.829625760684103*^9}, {
   3.8296261399293475`*^9, 3.829626140100858*^9}, 3.829626384192432*^9, {
   3.829626564618023*^9, 3.829626567315288*^9}, {3.829626762474454*^9, 
   3.829626787698028*^9}, {3.8296272402239556`*^9, 3.829627397032344*^9}, {
   3.829627485764617*^9, 3.829627534378626*^9}, {3.8296277750399485`*^9, 
   3.8296277903473434`*^9}, {3.8296278261919656`*^9, 3.829627830805027*^9}, {
   3.8296279053911133`*^9, 3.829627947252513*^9}, {3.829628063010292*^9, 
   3.8296280719843655`*^9}, {3.829628152656449*^9, 3.829628185219815*^9}, {
   3.829628227413541*^9, 3.829628297535626*^9}, {3.829628341789742*^9, 
   3.8296283618625126`*^9}, {3.8296441498783054`*^9, 
   3.8296441534341865`*^9}, {3.829644185382656*^9, 3.8296441871796675`*^9}, {
   3.8296442469479933`*^9, 3.8296442496261234`*^9}, 3.8296442956197104`*^9, {
   3.8296443562941175`*^9, 
   3.8296443855586653`*^9}},ExpressionUUID->"ce393230-dca9-4cb9-9b38-\
a73fba6403fa"],

Cell[BoxData["\<\"MusicScore`Private`\"\>"], "Output",
 CellChangeTimes->{{3.8296282512023153`*^9, 3.829628299884274*^9}, {
   3.82962836434976*^9, 3.8296283809435043`*^9}, 3.8296284238364005`*^9, {
   3.8296441965822835`*^9, 3.8296442086214046`*^9}, 3.8296443886399937`*^9, 
   3.8298013604769*^9, 
   3.8298014236995935`*^9},ExpressionUUID->"ee1c6bc5-4fcf-4f55-8da1-\
ea6272e639e6"]
}, Open  ]],

Cell[BoxData[""], "Input",
 CellChangeTimes->{3.8296282479456673`*^9, 
  3.829644200081072*^9},ExpressionUUID->"6237db40-4621-4a6d-a129-\
178c03ff0ddd"],

Cell[BoxData[""], "Input",
 CellChangeTimes->{{3.8296281852228394`*^9, 3.829628185227013*^9}, 
   3.829628247956626*^9, 
   3.8296442022855444`*^9},ExpressionUUID->"b270e15b-b6e8-423e-a0a6-\
679d34d7a844"],

Cell[BoxData[""], "Input",
 CellChangeTimes->{3.8296282479596243`*^9, 
  3.829644206610074*^9},ExpressionUUID->"9f660c53-7282-4384-aee1-\
558b28ac4224"]
},
WindowSize->{958, 1028},
WindowMargins->{{-7, Automatic}, {Automatic, 0}},
Magnification:>1.25 Inherited,
FrontEndVersion->"11.2 for Microsoft Windows (64-bit) (September 10, 2017)",
StyleDefinitions->"Default.nb"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[580, 22, 27680, 672, 2604, "Input",ExpressionUUID->"ce393230-dca9-4cb9-9b38-a73fba6403fa"],
Cell[28263, 696, 384, 6, 40, "Output",ExpressionUUID->"ee1c6bc5-4fcf-4f55-8da1-ea6272e639e6"]
}, Open  ]],
Cell[28662, 705, 152, 3, 35, "Input",ExpressionUUID->"6237db40-4621-4a6d-a129-178c03ff0ddd"],
Cell[28817, 710, 205, 4, 35, "Input",ExpressionUUID->"b270e15b-b6e8-423e-a0a6-679d34d7a844"],
Cell[29025, 716, 152, 3, 68, "Input",ExpressionUUID->"9f660c53-7282-4384-aee1-558b28ac4224"]
}
]
*)

