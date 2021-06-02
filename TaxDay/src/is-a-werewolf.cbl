       IDENTIFICATION DIVISION.
           FUNCTION-ID. IS-A-WEREWOLF.
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
              01 WS-SUPERMOONS.
               05 WS-SUPERMOON OCCURS 661 TIMES
                   ASCENDING KEY IS WS-MOON
                   INDEXED BY MOON-IDX.
                       10 WS-MOON PIC X(10).
           LINKAGE SECTION.
           01 LS-BIRTHDAY PIC X(10).
           01 LS-RESULT PIC A(5).
       PROCEDURE DIVISION USING LS-BIRTHDAY RETURNING LS-RESULT.
     
           SET MOON-IDX TO 0
           OPEN INPUT F-SUPERMOONS-FILE.
           MOVE 0 TO WS-FILE-IS-ENDED.
           PERFORM UNTIL WS-FILE-IS-ENDED = 1
                READ F-SUPERMOONS-FILE
                    NOT AT END 
                       ADD 1 TO MOON-IDX
                        MOVE MOON-DATE TO WS-SUPERMOON(MOON-IDX)
                     AT END 
                        MOVE 1 TO WS-FILE-IS-ENDED
                 END-READ
           END-PERFORM.
           CLOSE F-SUPERMOONS-FILE.

           SEARCH ALL WS-SUPERMOON
               WHEN WS-MOON(MOON-IDX) = LS-BIRTHDAY
                   MOVE 'TRUE' TO LS-RESULT
           END-SEARCH.

           END FUNCTION IS-A-WEREWOLF.
           

