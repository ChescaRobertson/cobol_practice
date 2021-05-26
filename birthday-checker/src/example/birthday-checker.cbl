       IDENTIFICATION DIVISION.
       PROGRAM-ID. birthday-checker.
       DATA DIVISION.
           LINKAGE SECTION.
           01 LS-NAME PIC A(10).
           01 LS-BIRTHDAY UNSIGNED-INT.
           01 LS-TODAY UNSIGNED-INT.
           01 LS-BIRTHDAY-GREETER PIC A(40).
       PROCEDURE DIVISION USING LS-NAME, LS-BIRTHDAY, LS-TODAY, LS-BIRT
      -    HDAY-GREETER.
      *     MOVE FUNCTION CURRENT-DATE(5:4) TO LS-TODAY
      *     DISPLAY "Name: " LS-NAME.
      *     DISPLAY "Birthday: " LS-BIRTHDAY.
      *     DISPLAY 1234
           
    
           IF LS-BIRTHDAY = LS-TODAY
               STRING "Happy Birthday " LS-NAME INTO LS-BIRTHDAY-GREETER
               DISPLAY LS-BIRTHDAY-GREETER
           ELSE 
               STRING "It is not your birthday" INTO LS-BIRTHDAY-GREETER
               DISPLAY LS-BIRTHDAY-GREETER
                
           END-IF.


           