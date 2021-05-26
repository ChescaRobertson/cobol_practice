       IDENTIFICATION DIVISION.
       PROGRAM-ID. birthday-checker.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 WS-RESULT UNSIGNED-INT.
           LINKAGE SECTION.
           01 LS-NAME PIC A(10).
           01 LS-BIRTHDAY PIC 9999. 
      *         03 LS-MONTH PIC 99.
      *         03 LS-DAY PIC 99.
           01 LS-TODAY PIC 9999.
      *         03 LS-MONTH PIC 99.
      *         03 LS-DAY PIC 99.
           01 LS-BIRTHDAY-GREETER PIC A(40).
       PROCEDURE DIVISION USING LS-NAME, LS-BIRTHDAY, LS-TODAY,
           LS-BIRTHDAY-GREETER.
      
           DISPLAY "Name: " LS-NAME.
           DISPLAY "Birthday: " LS-BIRTHDAY.
   
           IF LS-BIRTHDAY = LS-TODAY
               STRING "Happy Birthday " LS-NAME INTO LS-BIRTHDAY-GREETER
               END-STRING
               DISPLAY LS-BIRTHDAY-GREETER
           ELSE IF 
               LS-BIRTHDAY - LS-TODAY = 1
               STRING "It's almost your birthday " LS-NAME INTO 
               LS-BIRTHDAY-GREETER
               END-STRING
               DISPLAY LS-BIRTHDAY-GREETER
           ELSE 
               STRING "It is not your birthday " LS-NAME INTO 
               LS-BIRTHDAY-GREETER
               END-STRING
               DISPLAY LS-BIRTHDAY-GREETER 
           END-IF.


           