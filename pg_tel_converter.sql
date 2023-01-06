-- FUNCTION: public.tel_convert(text, text)

-- DROP FUNCTION IF EXISTS public.tel_convert(text, text);

CREATE OR REPLACE FUNCTION public.tel_convert(
str_ text,
rule_ text)
   RETURNS text
   LANGUAGE 'plpython3u'
   COST 100
   VOLATILE PARALLEL UNSAFE
AS $BODY$
out_ = ""
is_ = 0
ir_ = 0
ic_ = 0
lr_ = len(rule_)
ls_ = len(str_)
while True:
   ic_ += 1
   if ic_ >= 100:
       break
   if is_ < ls_ and ir_ == lr_:
       while True:
           out_ = out_ + str_[is_]
           is_ += 1
           if is_ >= ls_:
               break
       break
   if rule_[ir_] == "-":
       is_ += 1
       ir_ += 1
   if rule_[ir_] == "+":
       out0_ = ""
       ir_ += 1
       while True:
           if ir_ >= lr_:
               break
           if rule_[ir_] == "." or rule_[ir_] == "+" or rule_[ir_] == "-" or rule_[ir_] == "!" or rule_[ir_] == "?" or rule_[ir_].isalpha():
               out_ = out_ + out0_
               print("+ " + out0_)
               break
           out0_ = out0_ + rule_[ir_]
           ir_ += 1
   if rule_[ir_] == "!" or is_ == ls_:
       break
   if rule_[ir_] == "?":
       out_ = out_ + str_[is_]
   if rule_[ir_].isalnum() or rule_[ir_] == "*" or rule_[ir_] == "#"  or rule_[ir_] == "@" or rule_[ir_] == ".":
       out_ = out_ + rule_[ir_]
   if ir_ < lr_:
       ir_ += 1
       is_ += 1
   else:
       is_ += 1
return out_

$BODY$;

