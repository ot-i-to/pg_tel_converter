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
    if is_ < ls_ and ir_== lr_:
        ic0_ = 0
        while True:
            ic0_ += 1
            if ic0_ >= 100:
                break
            out_ = out_ + str_[is_]
            is_ += 1
            if is_ >= ls_:
                break
        break
    elif is_ == ls_:
        break
    elif rule_[ir_] == "!":
        break
    elif rule_[ir_] == "?" and ir_ <= (lr_ -1):
        out_ = out_ + str_[is_]
        is_ += 1
        if ir_ < lr_ :
            ir_ += 1
    elif rule_[ir_].isalnum() or rule_[ir_] == "*" or rule_[ir_] == "#"  or rule_[ir_] == "@" or rule_[ir_] == "." and ir_ <= (lr_ -1):
        out_ = out_ + rule_[ir_]
        is_ += 1
        if ir_ < lr_:
            ir_ += 1
    elif rule_[ir_] == "-" and ir_ <= (lr_ -1):
        is_ += 1
        if ir_ < lr_ :
            ir_ += 1
    elif rule_[ir_] == "+" and ir_ <= (lr_ -1):
        out0_ = ""
        ir_ += 1
        ic0_ = 0
        while True:
            ic0_ += 1
            if ic0_ >= 100:
                break
            if rule_[ir_] == "?" or rule_[ir_] == "+" or rule_[ir_] == "-" or rule_[ir_] == "!" or rule_[ir_].isalpha() and ir_== lr_:
                out_ = out_ + out0_
                break
            out0_ = out0_ + rule_[ir_]
            if ir_ < lr_:
                ir_ += 1
            else:
                break
            if ir_ >= lr_:
                break
return out_

$BODY$;

