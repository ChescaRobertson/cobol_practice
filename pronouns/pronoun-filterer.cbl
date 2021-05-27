       IDENTIFICATION DIVISION.
       PROGRAM-ID. pronoun-filterer.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT F-PEOPLE-FILE ASSIGN TO "people.dat"
                 ORGANISATION IS LINE SEQUENTIAL.
               SELECT F-SHE-HER-FILE ASSIGN TO "she-her-people.dat"
                  ORGANISATION IS LINE SEQUENTIAL ACCESS IS SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD F-PEOPLE-FILE.
           01 RC-PERSON.
             05 RC-PERSON-NAME PIC X(20).
             05 RC-PERSON-PRONOUN.
               10 RC-PERSON-PRONOUN-NOM PIC X(4). 
               10 RC-PERSON-PRONOUN-OBJ PIC X(4).
           FD F-SHE-HER-FILE.
           01 RC-SHE-HER-PERSON.
               05 RC-SHE-HER-PERSON-NAME PIC X(20).
               05 RC-SHE-HER-PERSON-PRONOUN.
                   10 RC-SHE-HER-PERSON-PRONOUN-NOM PIC X(4). 
                   10 RC-SHE-HER-PERSON-PRONOUN-OBJ PIC X(4).
           WORKING-STORAGE SECTION.
           01 WS-FILE-IS-ENDED PIC 9.
       PROCEDURE DIVISION.
           OPEN INPUT F-PEOPLE-FILE.
           OPEN EXTEND F-SHE-HER-FILE.
           MOVE 0 TO WS-FILE-IS-ENDED.

           PERFORM UNTIL WS-FILE-IS-ENDED = 1
               READ F-PEOPLE-FILE
                   NOT AT END 
                       IF RC-PERSON-PRONOUN-NOM = "she" 
                         AND RC-PERSON-PRONOUN-OBJ = "her"
                           WRITE RC-SHE-HER-PERSON FROM RC-PERSON
                           END-WRITE
                        END-IF
                       AT END 
                           MOVE 1 TO WS-FILE-IS-ENDED
                       END-READ
                       END-PERFORM.

           CLOSE F-PEOPLE-FILE.
           CLOSE F-SHE-HER-FILE. 
                           
               