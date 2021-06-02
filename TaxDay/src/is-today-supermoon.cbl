       IDENTIFICATION DIVISION.
           FUNCTION-ID. IS-TODAY-SUPERMOON.
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
           01 WS-SUPERMOONS.
               05 WS-SUPERMOON OCCURS 661 TIMES
                   ASCENDING KEY IS WS-MOON
                   INDEXED BY MOON-IDX.
                       10 WS-MOON PIC X(10).
           01 WS-FOUND PIC 9.
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

           MOVE "1922-04-11" TO WS-TODAY-DATE.

      *     IS-TODAY-SUPERMOON SECTION.
          *>  OPEN INPUT F-SUPERMOONS-FILE.
          *>  MOVE 0 TO WS-FILE-IS-ENDED.
       
          *>  PERFORM UNTIL WS-FILE-IS-ENDED = 1
          *>       READ F-SUPERMOONS-FILE
          *>           NOT AT END 
          *>               MOVE MOON-DATE TO WS-SUPERMOONS
          *>               DISPLAY WS-SUPERMOONS
          *>            AT END 
          *>               MOVE 1 TO WS-FILE-IS-ENDED
          *>        END-READ
          *>  END-PERFORM.
          *>  CLOSE F-SUPERMOONS-FILE.

           OPEN INPUT F-SUPERMOONS-FILE.
           MOVE 0 TO WS-FILE-IS-ENDED.
       
           PERFORM UNTIL WS-FILE-IS-ENDED = 1
                READ F-SUPERMOONS-FILE
                    NOT AT END 
                        IF MOON-DATE = WS-TODAY-DATE
                           MOVE 'TRUE' TO LS-RESULT
                     AT END 
                        MOVE 1 TO WS-FILE-IS-ENDED
                 END-READ
           END-PERFORM.
           CLOSE F-SUPERMOONS-FILE.

           DISPLAY WS-TODAY-DATE.
      *     DISPLAY WS-SUPERMOONS.

          *>  SEARCH ALL WS-SUPERMOON
          *>      WHEN WS-MOON(MOON-IDX) = WS-TODAY-DATE
          *>          MOVE 1 TO WS-FOUND
          *>      END-SEARCH.

          *>  IF WS-FOUND = 1
          *>      MOVE 'TRUE' TO LS-RESULT
          *>  ELSE    
          *>      MOVE 'FALSE' TO LS-RESULT
          *>  END-IF. 

           DISPLAY LS-RESULT.

           END FUNCTION IS-TODAY-SUPERMOON.
           

