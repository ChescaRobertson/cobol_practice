       IDENTIFICATION DIVISION.
           PROGRAM-ID. IS-TODAY-SUPERMOON.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
               SELECT F-SUPERMOONS-FILE ASSIGN TO "supermoons.dat"
                 ORGANISATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD F-SUPERMOONS-FILE.
           01 MOON.
             05 MOON-DATE.
                   10 MOON-YEAR PIC 9(4).
                   10 YEAR-MON-SEPARATOR PIC X.
                   10 MOON-MONTH PIC 99.
                   10 MON-DAY-SEPARATOR PIC X.
                   10 MOON-DAY PIC 99.
              05 APPARENT-MAGNITUDE PIC X(7).
           WORKING-STORAGE SECTION.
           01 WS-FILE-IS-ENDED PIC 9.
           01 WS-TODAY-DATE PIC X(10).
           01 WS-TODAY-DAY PIC 99.
           01 WS-TODAY-MONTH PIC 99.
           01 WS-TODAY-YEAR PIC 9999.
           01 RESULT PIC X(5).
           LINKAGE SECTION.
           01 LS-DATE PIC X(10).
           01 LS-RESULT PIC A(5).
       PROCEDURE DIVISION RETURNING LS-RESULT.

           MOVE FUNCTION CURRENT-DATE(5:2) TO WS-TODAY-MONTH.
           MOVE FUNCTION CURRENT-DATE(7:2) TO WS-TODAY-DAY
           MOVE FUNCTION CURRENT-DATE(1:4) TO WS-TODAY-YEAR.

           STRING WS-TODAY-YEAR "-" WS-TODAY-MONTH "-" WS-TODAY-DAY 
           INTO WS-TODAY-DATE
           END-STRING.

       IS-TODAY-SUPERMOON.
           OPEN INPUT F-SUPERMOONS-FILE.
           MOVE 0 TO WS-FILE-IS-ENDED.
       
           PERFORM UNTIL WS-FILE-IS-ENDED = 1
               READ F-SUPERMOONS-FILE
                   NOT AT END 
                      IF WS-TODAY-DATE = MOON-DATE
                       MOVE 'TRUE' TO LS-RESULT
                       DISPLAY LS-RESULT
                        END-DISPLAY
                    AT END 
                       MOVE 1 TO WS-FILE-IS-ENDED
                END-READ
           END-PERFORM.

           END FUNCTION IS-TODAY-SUPERMOON.
           