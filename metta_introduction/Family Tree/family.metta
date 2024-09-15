 ; Family Tree Knowledge Base
 ; Here we define the relationships in the family tree using the `Parent` and `Gender` predicates.
 ; "Parent A B" means A is the parent of B.
 ; "Gender X Y" means X is either male (M) or female (F).

(Parent Chandler John)
(Parent Chandler Pam)
(Parent John Bob)
(Parent Pam Tim)
(Parent Pam Kim)
(Parent Monica John)
(Parent Monica Pam)
(Parent Monica Adam)
(Parent Monica Jane)
(Parent Jane Joey)
(Parent Adam Eve)

(Gender Chandler M)
(Gender John M)
(Gender Bob M)
(Gender Tim M)
(Gender Kim M)
(Gender Adam M)
(Gender Joey M)

(Gender Monica F)
(Gender Jane F)
(Gender Eve F)
(Gender Kim F)
(Gender Pam F)

 ;; Rule 1: Get Parents
 ;; This rule returns the parents of a given person.
 ;; For example, (get-parents John) will return Chandler and Monica.
(= (get-parents $child)
    (match &self (Parent $parent $child) $parent))
! (get-parents John)

 ;; Rule 2: Get Grandparents
 ;; This rule returns the grandparents of a given person.
 ;; For example, (get-grand-parents Bob) will return Chandler and Monica.
(= (get-grand-parents $grandchild)
    (match &self (Parent $parent $grandchild) (get-parents $parent)))
! (get-grand-parents Bob)

 ;; Rule 3: Get Mother
 ;; This rule returns the mother of a given person.
 ;; For example, (get-mother Pam) will return Monica.
(= (get-mother $child)
    (match &self (Parent $parent $child)
        (match &self (Gender $parent F) $parent)))
! (get-mother Pam)

 ;; Rule 4: Get Father
 ;; This rule returns the father of a given person.
 ;; For example, (get-father John) will return Chandler.
(= (get-father $child)
    (match &self (Parent $parent $child)
        (match &self (Gender $parent M) $parent)))
! (get-father John)

 ;; Rule 5: Get Nephews
 ;; This rule returns the nephews of a given person (male descendants).
 ;; For example, (get-nephews John) will return Tim and Joey.
(= (get-nephews $relative)
    (match &self (Parent $sibling $relative)
        (match &self (Parent $sibling $nephew)
            (match &self (Parent $nephew $child)
                (match &self (Gender $child M) $child)))))
! (get-nephews John)

 ;; Rule 6: Get Nieces
 ;; This rule returns the nieces of a given person (female descendants).
 ;; For example, (get-niece John) will return Kim and Eve.
(= (get-niece $relative)
    (match &self (Parent $sibling $relative)
        (match &self (Parent $sibling $niece)
            (match &self (Parent $niece $child)
                (match &self (Gender $child F) $child)))))
! (get-niece John)

 ;; Rule 7: Get Predecessors
 ;; This rule returns the predecessors (parents and grandparents) of a person.
 ;; For example, (get-predecessors Bob) will return John, Chandler, and Monica.
(= (get-predecessors $descendant)
    (match &self (Parent $parent $descendant)
        (match &self (Parent $grandparent $parent)
            ($parent $grandparent))))
! (get-predecessors Bob)

 ;; Rule 8: Get Siblings
 ;; This rule returns the siblings of a given person.
 ;; For example, (get-siblings Pam) will return John, Adam, and Jane.
(= (get-siblings $person)
    (match &self (Parent $parent $person)
        (match &self (Parent $parent $sibling)
            (if (not (== $person $sibling)) $sibling (empty)))))
! (get-siblings Pam)

 ;; Rule 9: Get Uncles
 ;; This rule returns the uncles of a given person.
 ;; For example, (get-uncles Eve) will return John.
(= (get-uncles $person)
    (match &self (Parent $parent $person)
        (match &self (Parent $grandparent $parent)
            (match &self (Parent $grandparent $uncle)
                (match &self (Gender $uncle M) $uncle)))))
! (get-uncles Eve)

 ;; Rule 10: Get Sister
 ;; This rule returns the sister of a given person.
 ;; For example, (get-sister Pam) will return Jane.
(= (get-sister $person)
    (match &self (Parent $parent $person)
        (match &self (Parent $parent $sibling)
            (match &self (Gender $sibling F) $sibling))))
! (get-sister Pam)

 ;; Rule 11: Get Brother
 ;; This rule returns the brother of a given person.
 ;; For example, (get-brother Pam) will return John and Adam.
(= (get-brother $person)
    (match &self (Parent $parent $person)
        (match &self (Parent $parent $sibling)
            (match &self (Gender $sibling M) $sibling))))
! (get-brother Pam)

 ;; Rule 12: Get Grandchild
 ;; This rule returns the grandchildren of a given person.
 ;; For example, (get-grand-child Monica) will return Bob, Tim, Kim, Joey, and Eve.
(= (get-grand-child $grandparent)
    (match &self (Parent $grandparent $parent)
        (match &self (Parent $parent $grandchild) $grandchild)))
! (get-grand-child Monica)
