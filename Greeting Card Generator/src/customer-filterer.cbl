       IDENTIFICATION DIVISION.
       PROGRAM-ID. customer-filterer.
       ENVIRONMENT DIVISION.
           CONFIGURATION SECTION.
           REPOSITORY.
               FUNCTION IS-LEAP-YEAR.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.                                                   * Lists the files to be used within the program 
               SELECT F-CUSTOMERS-FILE ASSIGN TO "customers.dat"
                 ORGANISATION IS LINE SEQUENTIAL.
               SELECT F-CARDS-FILE ASSIGN TO "cards.dat"
                 ORGANISATION IS LINE SEQUENTIAL.
                SELECT F-TAX-CARDS-FILE ASSIGN TO "cards-tax-day.dat" 
                  ORGANISATION IS LINE SEQUENTIAL.
                SELECT F-WEREWOLF-FILE ASSIGN TO "werewolf-cards.dat" 
                  ORGANISATION IS LINE SEQUENTIAL.
               SELECT F-SUPERMOONS-FILE ASSIGN TO "supermoons.dat"
                 ORGANISATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD F-CUSTOMERS-FILE.                                            * File description for customers file
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
           FD F-CARDS-FILE.                                                 * File description for cards file
           01 CARDS-PERSON.
               05 CARDS-PERSON-NAME PIC X(40).
               05 CARDS-PERSON-ADDRESS PIC X(100).
               05 CARDS-GREETING PIC X(56).
           FD F-TAX-CARDS-FILE.                                             * File description for tax cards file
           01 TAX-CARDS-PERSON.
               05 TAX-CARDS-PERSON-NAME PIC X(40).
               05 TAX-CARDS-PERSON-ADDRESS PIC X(100).
               05 TAX-CARDS-GREETING PIC X(56).
           FD F-WEREWOLF-FILE.                                              * File description for werewolf cards file
           01 WEREWOLF-PERSON.
               05 WEREWOLF-NAME PIC X(40).
               05 WEREWOLF-ADDRESS PIC X(100).
               05 WEREWOLF-GREETING PIC X(56).
           FD F-SUPERMOONS-FILE.                                            * File description for supermoons file
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
           01 WS-DATE-FORMAT PIC X(10).
           01 WS-SUPERMOONS.                                               * Set up for supermoon table
              05 WS-SUPERMOON OCCURS 661 TIMES
                  ASCENDING KEY IS WS-MOON
                  INDEXED BY MOON-IDX.
                      10 WS-MOON PIC X(10).
           LINKAGE SECTION.
           01 LS-TODAY.
               05 LS-TODAY-MONTH PIC 99.
               05 LS-MON-DAY-SEPARATOR PIC X.
               05 LS-TODAY-DAY PIC 99.
           01 LS-TODAY-YEAR PIC 9999.
         
       PROCEDURE DIVISION USING LS-TODAY, LS-TODAY-YEAR. 

           STRING LS-TODAY-YEAR "-" LS-TODAY INTO WS-DATE-FORMAT           * Put the date into correct format YYYY-MM-DD
           END-STRING.
  
           IF LS-TODAY = "04-06"                                           * Checking if today is a tax day, if so send tax cards
               PERFORM TAX-DAY
           END-IF.

           OPEN INPUT F-SUPERMOONS-FILE
           SET MOON-IDX TO 0                                               * Creating table of supermoon dates for werewolf search
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

           SEARCH ALL WS-SUPERMOON                                         * Checking if today is a supermoon, if so send werewolf cards
               WHEN WS-MOON(MOON-IDX) = WS-DATE-FORMAT
                   PERFORM WEREWOLF
           END-SEARCH.

           PERFORM BIRTHDAY.                                               * Perform birthday every day and terminate to avoid repetition
           GOBACK.

           TAX-DAY SECTION.                                                * Sends cards to everyone over 18 tax day
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

           BIRTHDAY SECTION.                                               * Sends birthday cards to everyone on their birthday
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
   
           WEREWOLF SECTION.                                               * Sends greeting to all werewolfs on a supermoon 
           MOVE 0 TO WS-FILE-IS-ENDED.
           OPEN INPUT F-CUSTOMERS-FILE.
           OPEN EXTEND F-WEREWOLF-FILE.
           PERFORM UNTIL WS-FILE-IS-ENDED = 1
               READ F-CUSTOMERS-FILE
                   NOT AT END
                       SEARCH ALL WS-SUPERMOON 
                           WHEN WS-MOON(MOON-IDX) = PERSON-BIRTHDAY
                           MOVE PERSON-NAME TO WEREWOLF-NAME
                           MOVE PERSON-ADDRESS TO WEREWOLF-ADDRESS
                           STRING "Awoo " PERSON-NAME 
                           INTO WEREWOLF-GREETING
                           END-STRING
                           WRITE WEREWOLF-PERSON
                           END-WRITE
                        END-SEARCH
                    AT END
                       MOVE 1 TO WS-FILE-IS-ENDED
                END-READ
           END-PERFORM.
           CLOSE F-CUSTOMERS-FILE.
           CLOSE F-WEREWOLF-FILE. 

           
           