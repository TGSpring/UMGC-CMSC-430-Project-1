/*
Tyler Spring
1/23/23
Project 1
This is the listing.cc file. Here the computations for errors in each line,
as well as the entire file are done and displayed.
*/

#include <cstdio>
#include <string>


using namespace std;
//used to create queue and use cout.
#include "listing.h"
#include <queue>
#include <iostream>
static int lineNumber;
static string error = "";
static int totalErrors = 0;
//totals for each type of error to be displayed at the end.
static int lexErr = 0;
static int synErr = 0;
static int semErr = 0;
//Queue made for errors on each line.
static queue<string>lexQue;


static void displayErrors();
//first line method provided.
void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}
//next line method provided.
void nextLine()
{
	lineNumber++;
	displayErrors();
	printf("%4d  ",lineNumber);
}
//last line method. Here the total errors are checked, if are none, compiled succesfully is printed
//If their are errors, the totals gathered are printed, as well as the total errors.
int lastLine()
{
	printf("\r");
	displayErrors();
	printf("     \n");
	if (totalErrors == 0){
		return printf("Compiled Successfully\n");
	}else {
		printf("total errors is: %d\n", totalErrors);
		printf("Lexical Errors: %d\n", lexErr);
		printf("Snytactical Errors: %d\n", synErr);
		printf("Semantic Errors: %d\n", semErr);
		return 0;	
		}
		}
 //Append Error method. Here the errors found are ran with the enum types of this classes header
 //header file. If errors are found, they are added to the total errors, then to their
 //specific error, then to a queue.   
void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = { "Lexical Error, Invalid Character ", "",
		"Semantic Error, ", "Semantic Error, Duplicate Identifier: ",
		"Semantic Error, Undeclared " , "Snytactical Error ", ""};

	
	error = messages[errorCategory] + message;
	
	totalErrors++;
	if(error.find("LEXICAL")){
		lexErr++;
		lexQue.push(error);
	} else if(error.find("SYNTAX")){
		synErr++;
		lexQue.push(error);
	} else if(error.find("GENERAL_SEMANTIC")){
		semErr++;
		lexQue.push(error);
	}
		
}
//display errors method. The queue of errors is ran through a while loop and prints 
//all the errors found after each line.
void displayErrors()
{
//that c_str function ruined me for the longest time due to me not paying attention.
	while (!lexQue.empty()){
	if (error != "")
		cout <<lexQue.front() << " \n";
		lexQue.pop();
		}
	error = "";
}
