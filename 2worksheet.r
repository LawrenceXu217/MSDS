# Worksheet 2
#PART 3
#(a)	(2 point) Consider the table of counts using SEX and CLASS, you created above. Add margins to this table 
# (Hint: There should be 15 cells in this table plus the marginal totals. Apply *table()* first, 
# then pass the table object to *addmargins()* (Kabacoff Section 7.2 pages 144-147)).
# Lastly, present a barplot of these data; ignoring the marginal totals. 
 s_cls_table <- table(mydata$SEX, mydata$CLASS)
 sex_class_table_with_margins <- addmargins(s_cls_table)
