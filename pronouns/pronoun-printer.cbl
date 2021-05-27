       IDENTIFICATION DIVISION.
       PROGRAM-ID. pronoun-printer.
       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT F-PEOPLE-FILE ASSIGN TO "people.dat"
                 ORGANISATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD F-PEOPLE-FILE.
           01 RC-PERSON.
             05 RC-PERSON-NAME PIC X(20).
             05 RC-PERSON-PRONOUN.
               10 RC-PERSON-PRONOUN-NOM PIC X(4). 
               10 RC-PERSON-PRONOUN-OBJ PIC X(4).
           WORKING-STORAGE SECTION.
           01 WS-FILE-IS-ENDED PIC 9.
       PROCEDURE DIVISION.
           OPEN INPUT F-PEOPLE-FILE.
           MOVE 0 TO WS-FILE-IS-ENDED.

           PERFORM UNTIL WS-FILE-IS-ENDED = 1
               READ F-PEOPLE-FILE
                   NOT AT END 
                       DISPLAY 
                           FUNCTION TRIM(RC-PERSON-NAME)
                           "'s pronouns are "
                            FUNCTION TRIM(RC-PERSON-PRONOUN-NOM)
                            "/"
                            FUNCTION TRIM(RC-PERSON-PRONOUN-OBJ)
                            "."
                        END-DISPLAY
                    AT END 
                       MOVE 1 TO WS-FILE-IS-ENDED
                    END-READ
                   END-PERFORM.

           CLOSE F-PEOPLE-FILE.

       