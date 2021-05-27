       IDENTIFICATION DIVISION.
       PROGRAM-ID. happy_birthday.
       DATA DIVISION.
           LINKAGE SECTION.
           01 LS-NAME PIC X(10).
           01 LS-RESULT PIC X(100).
           PROCEDURE DIVISION USING LS-NAME, LS-RESULT.
      *    DISPLAY "What is your name?"
      *    ACCEPT YOUR-NAME.
           STRING "Happy Birthday " LS-NAME INTO LS-RESULT
           END-STRING.
      *    DISPLAY "Happy Birthday " YOUR-NAME.
       