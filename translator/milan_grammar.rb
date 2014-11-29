begin             1     0
end               2     0
if                3     0
then              4     0
else              5     0
while             6     0
do                7     0
for               8     0
to                9     0
read              10    0
write             11    0
var               12    0
and               13    0
or                14    0
integer           15    0
string            16    0
;                 20    0
=                 21    0
<>                21    1
<                 21    2
>                 21    3
<=                21    4
>=                21    5
+                 22    0
-                 22    1
*                 23    0
/                23    1
:=                24    0
(                 25    0
)                 26    0
:                 27    0
.                 28    0
,                 29    0
getcolorrgb       42    0
drawpoint         43    0
drawline          44    0
drawcircle        45    0
getpixelcolor     46    0
clrscr            47    0
color             48    0
@id               30    0
@nconst           40    0
@sconst           41    0

program           100   0
var_define        101   0
var_list          102   0
var_block         103   0
names_list        104   0
type              105   0
program_body      106   0
operators_list    107   0
operator          108   0
condition         109   0
comparation       110   0
logic_operator    111   0
expression        112   0
num_expression    113   0
str_expression    114   0
term              115   0
multiplier        116   0
str_term          117   0
color_expression  118   0
ending            119   0

<program>               ::=   <var_define> <program_body>
<var_define>            ::=   "var" <var_list>,
<var_list>              ::=   <var_block> <var_list>
<var_list>              ::=   <var_block>
<var_block>             ::=   <names_list> <type>
<names_list>            ::=   "@id"
<names_list>            ::=   "@id" <names_list>
<type>                  ::=   "integer"
<type>                  ::=   "string"
<type>                  ::=   "color"
<program_body>          ::=   "begin" <operators_list> "end"
<operators_list>        ::=   <operator>
<operators_list>        ::=   <operator> ";" <operators_list>
<operator>              ::=   "@id" <expression>
<operator>              ::=   "if" <condition> "then" <operator>
<operator>              ::=   "if" <condition> "then" <operator> "else" <operator>
<operator>              ::=   "while" <condition> "do" <operator>
<operator>              ::=   "for" "@id" ":=" <expression> "to" <expression> "do" <operator>
<operator>              ::=   "write" "(" <expression> ")"
<operator>              ::=   "read" "(" "@id" ")"
<operator>              ::=   "drawpoint" "(" <num_expression> "," <num_expression> "," <color_expression> ")",
<operator>              ::=   "drawline" "(" <num_expression> "," <num_expression> "," <num_expression> "," <num_expression> "," <color_expression> ")"
<operator>              ::=   "drawcircle" "(" <num_expression> "," <num_expression> "," <num_expression> "," <color_expression> ")"
<operator>              ::=   "getpixelcolor" "(" <num_expression> "," <num_expression> ")"
<operator>              ::=   "clrscr" "(" <color_expression> ")"
<operator>              ::=   "begin" <operators_list> "end"
<condition>             ::=   <comparation>
<condition>             ::=   <comparation> <logic_operator> <condition>
<comparation>           ::=   <expression> "=" <expression>
<logic_operator>        ::=   "and"
<logic_operator>        ::=   "or"
<expression>            ::=   <num_expression>
<expression>            ::=   <str_expression>
<expression>            ::=   <color_expression>
<num_expression>        ::=   <term>
<num_expression>        ::=   <term> "+" <num_expression>
<term>                  ::=   <multiplier>
<term>                  ::=   <multiplier> "*" <term>
<multiplier>            ::=   "@id"
<multiplier>            ::=   "(" <num_expression ")"
<multiplier>            ::=   "@nconst"
<str_expression>        ::=   <str_term>
<str_expression>        ::=   <str_term> "+" <str_expression>
<str_term>              ::=   "@id"
<str_term>              ::=   "@sconst"
<color_expression>      ::=   "@id"
<color_expression>      ::=   "getcolorrgb" "(" <num_expression> "," <num_expression> "," <num_expression> ")"