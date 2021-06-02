       IDENTIFICATION DIVISION.
       PROGRAM-ID. customer-filterer.
       ENVIRONMENT DIVISION.
           CONFIGURATION SECTION.
           REPOSITORY.
               FUNCTION IS-LEAP-YEAR
               FUNCTION IS-TODAY-SUPERMOON
               FUNCTION IS-A-WEREWOLF.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT F-CUSTOMERS-FILE ASSIGN TO "customers.dat"
                 ORGANISATION IS LINE SEQUENTIAL.
               SELECT F-CARDS-FILE ASSIGN TO "cards.dat"
                 ORGANISATION IS LINE SEQUENTIAL.
                SELECT F-TAX-CARDS-FILE ASSIGN TO "cards-tax-day.dat" 
                  ORGANISATION IS LINE SEQUENTIAL.
                SELECT F-WEREWOLF-FILE ASSIGN TO "werewolf-cards.dat" 
                  ORGANISATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD F-CUSTOMERS-FILE.
           01 PERSON.
               05 PERSON-NAME PIC X(40).
               05 PERSON-ADDRESS PIC X(100).
               05 PERSON-BIRTHDAY.
                   10 BIRTHDAY-YEAR PIC 9(4).
                   10 YEAR-MON-SEPARATOR PIC X.
                   10 BIRTHDAY-MONTH PIC 99.
                   10 MON-DAY-SEPARATOR PIC X.
                   10 BIRTHDAY-DAY PIC 99.
               05 PERSON-JOB-TITLE PIC X(60).
           FD F-CARDS-FILE.
           01 CARDS-PERSON.
               05 CARDS-PERSON-NAME PIC X(40).
               05 CARDS-PERSON-ADDRESS PIC X(100).
               05 CARDS-GREETING PIC X(56).
           FD F-TAX-CARDS-FILE.
           01 TAX-CARDS-PERSON.
               05 TAX-CARDS-PERSON-NAME PIC X(40).
               05 TAX-CARDS-PERSON-ADDRESS PIC X(100).
               05 TAX-CARDS-GREETING PIC X(56).
           FD F-WEREWOLF-FILE.
           01 WEREWOLF-PERSON.
               05 WEREWOLF-NAME PIC X(40).
               05 WEREWOLF-ADDRESS PIC X(100).
               05 WEREWOLF-GREETING PIC X(56).
           WORKING-STORAGE SECTION.
           01 WS-FILE-IS-ENDED PIC 9.
           01 WS-DATE-FORMAT PIC 9(8).
           LINKAGE SECTION.
           01 LS-TODAY.
               05 LS-TODAY-MONTH PIC 99.
               05 LS-MON-DAY-SEPARATOR PIC X.
               05 LS-TODAY-DAY PIC 99.
           01 LS-TODAY-YEAR PIC 9999.
       PROCEDURE DIVISION USING LS-TODAY, LS-TODAY-YEAR. 
           IF LS-TODAY = "04-06" 
               PERFORM TAX-DAY
           END-IF.

      *     DISPLAY FUNCTION IS-TODAY-SUPERMOON 

           IF FUNCTION IS-TODAY-SUPERMOON = 'TRUE'
             PERFORM WEREWOLF
           END-IF.

           PERFORM BIRTHDAY. 
           GOBACK.

           TAX-DAY SECTION.
           MOVE 0 TO WS-FILE-IS-ENDED.
           OPEN INPUT F-CUSTOMERS-FILE.
           OPEN EXTEND F-TAX-CARDS-FILE.
           PERFORM UNTIL WS-FILE-IS-ENDED = 1
              READ F-CUSTOMERS-FILE
               NOT AT END
                   IF (LS-TODAY-YEAR - BIRTHDAY-YEAR > 18) OR 
                   (LS-TODAY-YEAR - BIRTHDAY-YEAR = 18 AND
                   BIRTHDAY-MONTH >= LS-TODAY-MONTH AND
                   BIRTHDAY-DAY >= LS-TODAY-DAY)
                       MOVE PERSON-NAME TO TAX-CARDS-PERSON-NAME
                       MOVE PERSON-ADDRESS TO TAX-CARDS-PERSON-ADDRESS
                       STRING "Happy Tax Day, " PERSON-NAME 
                          INTO TAX-CARDS-GREETING
                           END-STRING
                           WRITE TAX-CARDS-PERSON
                           END-WRITE
                       END-IF
                    AT END
                       MOVE 1 TO WS-FILE-IS-ENDED
                END-READ
           END-PERFORM.
           CLOSE F-CUSTOMERS-FILE.
           CLOSE F-TAX-CARDS-FILE.

                  
           BIRTHDAY SECTION.
           MOVE 0 TO WS-FILE-IS-ENDED.
           OPEN INPUT F-CUSTOMERS-FILE
           OPEN EXTEND F-CARDS-FILE.
           PERFORM UNTIL WS-FILE-IS-ENDED = 1
               READ F-CUSTOMERS-FILE
                   NOT AT END
                   IF BIRTHDAY-MONTH = '02' AND BIRTHDAY-DAY = '29' AND
                   FUNCTION IS-LEAP-YEAR(LS-TODAY-YEAR) = 'FALSE'
                          MOVE '0000-03-01' TO PERSON-BIRTHDAY
                   END-IF
                       IF PERSON-BIRTHDAY(6:5) = LS-TODAY
                           MOVE PERSON-NAME TO CARDS-PERSON-NAME
                           MOVE PERSON-ADDRESS TO CARDS-PERSON-ADDRESS
                           STRING "Happy Birthday, " PERSON-NAME 
                           INTO CARDS-GREETING
                           END-STRING
                           WRITE CARDS-PERSON
                           END-WRITE
                       END-IF
                    AT END
                       MOVE 1 TO WS-FILE-IS-ENDED
                END-READ
           END-PERFORM.
           CLOSE F-CUSTOMERS-FILE.
           CLOSE F-CARDS-FILE.
           
           WEREWOLF SECTION.
           MOVE 0 TO WS-FILE-IS-ENDED.
           OPEN INPUT F-CUSTOMERS-FILE.
           DISPLAY "OPENING CUSTOMERS FILE"
           OPEN EXTEND F-WEREWOLF-FILE.
           DISPLAY "OPENING WEREWOLF FILE"
           PERFORM UNTIL WS-FILE-IS-ENDED = 1
               READ F-CUSTOMERS-FILE
                   NOT AT END
                      IF IS-A-WEREWOLF(PERSON-BIRTHDAY) = 'TRUE'
                           MOVE PERSON-NAME TO WEREWOLF-NAME
                           MOVE PERSON-ADDRESS TO WEREWOLF-ADDRESS
                           STRING "Awoo " PERSON-NAME 
                           INTO WEREWOLF-GREETING
                           END-STRING
                           WRITE WEREWOLF-PERSON
                           END-WRITE
                      END-IF
                    AT END
                       MOVE 1 TO WS-FILE-IS-ENDED
                END-READ
           END-PERFORM.
           CLOSE F-CUSTOMERS-FILE.
           CLOSE F-WEREWOLF-FILE. 

           
           