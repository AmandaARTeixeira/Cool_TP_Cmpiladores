/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */

%option noyywrap

%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */

%}

/*
 * Define names for regular expressions here.
 */

/*
* Definition of multiple-character operators.
*/

DARROW          =>
ASSIGN          <-
LE              <=

/*
* Definition of case insensitive identifiers.
*/

IF              (?i:if)
ELSE            (?i:else)
FI              (?i:fi)
CLASS           (?i:class)
IN              (?i:in)
INHERITS        (?i:inherits)
LET             (?i:let)
LOOP            (?i:loop)
POOL            (?i:pool)
THEN            (?i:then)
WHILE           (?i:while)
CASE            (?i:case)
ESAC            (?i:esac)
OF              (?i:of)
NEW             (?i:new)
ISVOID          (?i:isvoid)
NOT             (?i:not)


/*
* Definition of true and false (case sensitive)
*/
TRUE            (t)(?i:rue)
FALSE           (f)(?i:alse)

%%

 /*
  *  The multiple-character operators.
  */
{DARROW}		{ return (DARROW); }
{ASSIGN}        { return (ASSIGN); }
{LE}            { return (LE); }

 
 /*
  * Identifiers case insensite
  */

{IF}            return IF;
{ELSE}          return ELSE;
{FI}            return FI;
{CLASS}         return CLASS;
{IN}            return IN;
{INHERITS}      return INHERITS;
{LET}           return LET;
{LOOP}          return LOOP;
{POOL}          return POOL;
{THEN}          return THEN;
{WHILE          return WHILE;
{CASE}          return CASE;
{ESAC}          return ESAC;
{OF}            return OF;
{NEW}           return NEW;
{ISVOI          return ISVOID;
{NOT}           return NOT;


 /*
 * Bool identifiers
 */
{TRUE}      {
            cool_yylval.boolean = true;
				return BOOL_CONST;
        }
{FALSE}     {
				cool_yylval.boolean = false;
				return BOOL_CONST;
			}



 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */


%%
