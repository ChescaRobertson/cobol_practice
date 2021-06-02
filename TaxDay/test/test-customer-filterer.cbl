       IDENTIFICATION DIVISION.
       PROGRAM-ID. test-customer-filterer.
       PROCEDURE DIVISION.
       TEST-BIRTHDAY-CARD-SENT.
           CALL "customer-filterer" USING "03-05", "2021".

       TEST-BIRTHDAY-CARD-NOT-SENT.
           SET ENVIRONMENT "cards_dat" TO "cards-birthday-0101.dat".
           CALL "customer-filterer" USING "01-01", "2021".

       TEST-TAX-CARD-SENT.
           SET ENVIRONMENT "cards_dat" TO "cards-tax-day.dat".
           CALL "customer-filterer" USING "04-06", "2021".
       
       TEST-LEAP-YEAR-BIRTHDAYS-ON-LEAP-YEAR.
           SET ENVIRONMENT "cards_dat" TO "cards-leap-year-0229.dat".
           CALL "customer-filterer" USING "02-29", "2024".

       TEST-LEAP-YEAR-BIRTHDAYS-ON-NON-LEAP-YEAR.
           SET ENVIRONMENT "cards_dat" TO "cards-leap-year-0301.dat".
           CALL "customer-filterer" USING "03-01", "2022".
           
       TEST-WEREWOLF-CARDS-SENT.
           SET ENVIRONMENT "cards_dat" TO "werewolf-cards.dat"  
           CALL "customer-filterer" USING "06-24", "2021". 




           