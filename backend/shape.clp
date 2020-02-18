;;;***************
;;;* BASIC RULES *
;;;***************

;;;************
;;;* TRIANGLE *
;;;************

(defrule determine-sama-sisi ""
    (segitiga yes)
    (sudut-1 60)
    (sudut-2 60)
    (sudut-3 60)
    =>
    (assert (segitiga-sama-sisi-final yes)))

(defrule determine-sama-kaki ""
    (segitiga yes)
    (not(segitiga-sama-sisi ?))
    (sudut-1 ?x)
    (sudut-2 ?y)
    (sudut-3 ?z)
    =>
    (if(or (= ?x ?y) (= ?y ?z) (= ?z ?x))
    then
    (assert (segitiga-sama-kaki yes))))

(defrule determine-siku-siku ""
    (segitiga yes)
    (not(segitiga-sama-sisi ?))
    (sudut-1 ?x)
    (sudut-2 ?y)
    (sudut-3 ?z)
    =>
    (if (or (= ?x 90) (= ?y 90) (= ?z 90)) 
    then
    (assert (segitiga-siku-siku yes))))

(defrule determine-tumpul ""
    (segitiga yes)
    (not(segitiga-sama-sisi yes))
    (sudut-1 ?x)
    (sudut-2 ?y)
    (sudut-3 ?z)
    =>
    (if(or (> ?x 90) (> ?y 90) (> ?z 90))
    then
    (assert (segitiga-tumpul yes))))

(defrule determine-lancip ""
    (segitiga yes)
    (not(segitiga-sama-sisi yes))
    (sudut-1 ?x)
    (sudut-2 ?y)
    (sudut-3 ?z)
    =>
    (if(and (< ?x 90) (< ?y 90) (< ?z 90))
    then
    (assert (segitiga-lancip yes))))

;;;**************
;;;* QUADRANGLE *
;;;**************

(defrule determine-jajaran-genjang ""
    (segiempat yes)
    (sudut-1 ?x)
    (sudut-2 ?y)
    (sudut-3 ?z)
    (sudut-4 ?u)
    =>
    (if(and (= ?x ?z) (= ?y ?u))
    then
    (assert (jajaran-genjang yes))))

(defrule determine-segiempat-beraturan ""
    (segiempat yes)
    (jajaran-genjang yes)
    (sudut-1 90)
    (sudut-2 90)
    (sudut-3 90)
    (sudut-4 90)
    =>
    (assert (segiempat-beraturan-final yes)))

(defrule determine-layang-layang ""
    (segiempat yes)
    (jajaran-genjang yes)
    (not (segiempat-beraturan ?))
    =>
    (assert (layang-layang-final yes)))

(defrule determine-trapesium ""
    (segiempat yes)
    (not (jajaran-genjang ?))
    (sudut-1 ?x)
    (sudut-2 ?y)
    (sudut-3 ?z)
    (sudut-4 ?u)
    =>
    (if(or (= ?x ?y) (= ?y ?z) (= ?z ?u) (= ?u ?x))
    then
    (assert (trapesium yes))))

(defrule determine-trapesium-sama-kaki ""
    (segiempat yes)
    (trapesium yes)
    (sudut-1 ?x)
    (sudut-2 ?y)
    (sudut-3 ?z)
    (sudut-4 ?u)
    =>
    (if (or (and (= ?x ?y) (= ?z ?u)) (and (= ?x ?u) (= ?y ?z)))
    then
    (assert (trapesium-sama-kaki-final yes))))

(defrule determine-trapesium-rata-kiri ""
    (segiempat yes)
    (trapesium yes)
    (sudut-1 90)
    (sudut-4 90)
    =>
    (assert (trapesium-rata-kiri-final yes)))
    
(defrule determine-trapesium-rata-kanan ""
    (segiempat yes)
    (trapesium yes)
    (sudut-2 90)
    (sudut-3 90)
    =>
    (assert (trapesium-rata-kanan-final yes)))


;;;**************
;;;* PENTAGON *
;;;**************

(defrule determine-segilima-sama-sisi ""
    (segilima yes)
    (sudut-1 ?x)
    (sudut-2 ?y)
    (sudut-3 ?z)
    (sudut-4 ?u)
    (sudut-5 ?v)
    =>
    (if(and (= ?x ?y) (= ?y ?z) (= ?z ?u) (= ?u ?v))
    then
    (assert (segilima-sama-sisi-final yes))
    else
    (assert (segilima-tidak-beraturan-final yes))))


;;;***********
;;;* HEXAGON *
;;;***********

(defrule determine-segienam-sama-sisi ""
    (segienam yes)
    (sudut-1 ?x)
    (sudut-2 ?y)
    (sudut-3 ?z)
    (sudut-4 ?u)
    (sudut-5 ?v)
    (sudut-6 ?w)
    =>
    (if(and (= ?x ?y) (= ?y ?z) (= ?z ?u) (= ?u ?v) (= ?v ?w))
    then
    (assert (segienam-sama-sisi-final yes))
    else
    (assert (segienam-tidak-beraturan-final yes))))


;;;***************
;;;* FINAL RULES *
;;;***************
    
(defrule final-kaki-siku ""
    (segitiga-sama-kaki yes)
    (segitiga-siku-siku yes)
    =>
    (assert (segitiga-kaki-siku-final yes)))

(defrule final-kaki-tumpul ""
    (segitiga-sama-kaki yes)
    (segitiga-tumpul yes)
    =>
    (assert (segitiga-kaki-tumpul-final yes)))

(defrule final-kaki-lancip ""
    (segitiga-sama-kaki yes)
    (segitiga-lancip yes)
    =>
    (assert (segitiga-kaki-lancip-final yes)))

(defrule final-lancip ""
    (segitiga-lancip yes)
    (not (segitiga-kaki-lancip-final yes))
    =>
    (assert (segitiga-lancip-final yes)))

(defrule final-tumpul ""
    (segitiga-tumpul yes)
    (not (segitiga-kaki-lancip-final yes))
    =>
    (assert (segitiga-tumpul-final yes)))

(defrule final-siku ""
    (segitiga-siku-siku yes)
    (not (segitiga-kaki-siku-final yes))
    =>
    (assert (segitiga-siku-siku-final yes)))

(defrule final-segiempat-tidak-beraturan ""
    (segiempat yes)
    (not (segiempat-beraturan-final yes))
    (not (layang-layang-final yes))
    (not (trapesium-sama-kaki-final yes))
    (not (trapesium-rata-kiri-final yes))
    (not (trapesium-rata-kanan-final yes))
    =>
    (assert (segiempat-tidak-beraturan-final yes)))


;;;****************
;;;* RESULT RULES *
;;;****************

(defrule tidak-beraturan-empat ""
   (segiempat-tidak-beraturan-final yes)
   (not (result ?))
   =>
   (assert (result "Segiempat tidak beraturan")))

(defrule tidak-beraturan-lima ""
   (segilima-tidak-beraturan-final yes)
   (not (result ?))
   =>
   (assert (result "Segilima tidak beraturan")))

(defrule tidak-beraturan-enam ""
   (segienam-tidak-beraturan-final yes)
   (not (result ?))
   =>
   (assert (result "Segienam tidak beraturan")))

(defrule result-segitiga-sama-sisi ""
   (segitiga-sama-sisi-final yes)
   (not (result ?))
   =>
   (assert (result "Segitiga sama sisi")))

(defrule result-segitiga-kaki-siku ""
   (segitiga-kaki-siku-final yes)
   (not (result ?))
   =>
   (assert (result "Segitiga sama kaki siku-siku")))

(defrule result-segitiga-kaki-lancip ""
   (segitiga-kaki-lancip-final yes)
   (not (result ?))
   =>
   (assert (result "Segitiga sama kaki lancip")))

(defrule result-segitiga-kaki-tumpul ""
   (segitiga-kaki-tumpul-final yes)
   (not (result ?))
   =>
   (assert (result "Segitiga sama kaki tumpul")))

(defrule result-segitiga-siku-siku ""
   (segitiga-siku-siku-final yes)
   (not (result ?))
   =>
   (assert (result "Segitiga siku-siku")))

(defrule result-segitiga-tumpul ""
   (segitiga-tumpul-final yes)
   (not (result ?))
   =>
   (assert (result "Segitiga tumpul")))

(defrule result-segitiga-lancip ""
   (segitiga-lancip-final yes)
   (not (result ?))
   =>
   (assert (result "Segitiga lancip")))

(defrule result-segiempat-beraturan ""
   (segiempat-beraturan-final yes)
   (not (result ?))
   =>
   (assert (result "Segiempat beraturan")))

(defrule result-layang-layang ""
   (layang-layang-final yes)
   (not (result ?))
   =>
   (assert (result "Layang-layang")))

(defrule result-trapesium-sama-kaki ""
   (trapesium-sama-kaki-final yes)
   (not (result ?))
   =>
   (assert (result "Trapesium sama kaki")))

(defrule result-trapesium-rata-kiri ""
   (trapesium-rata-kiri-final yes)
   (not (result ?))
   =>
   (assert (result "Trapesium rata kiri")))

(defrule result-trapesium-rata-kanan ""
   (trapesium-rata-kanan-final yes)
   (not (result ?))
   =>
   (assert (result "Trapesium rata kanan")))

(defrule result-segilima-sama-sisi ""
   (segilima-sama-sisi-final yes)
   (not (result ?))
   =>
   (assert (result "Segilima sama sisi")))

(defrule result-segienam-sama-sisi ""
   (segienam-sama-sisi-final yes)
   (not (result ?))
   =>
   (assert (result "Segienam sama sisi")))

(defrule print-result ""
  (declare (salience 10))
  (result ?item)
  =>
  (format t "%s" ?item))