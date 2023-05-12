/* 
Tyler Spring
1/23/23
Project 1
This is the listing.h file. The enum types are stored for errors. This file worked fine, so I did
not even attempt to mess with it.
*/
// This file contains the function prototypes for the functions that produce the // compilation listing

enum ErrorCategories {LEXICAL, SYNTAX, GENERAL_SEMANTIC, DUPLICATE_IDENTIFIER,
	UNDECLARED};

void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);

