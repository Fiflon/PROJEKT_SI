(deftemplate pytanie
    (slot name)
    (slot question)
    (multislot answers)
    (slot picked)
)

(deftemplate book
    (slot author)
    (slot title)
)



(assert (first ""))


(defrule genre
    ?ff <- (first "")
    =>
    (retract ?ff)
    (assert (pytanie (name "genre") (question "Which type of book are you looking for?") (answers "Fantasy" "Sci-Fi" "A little bit of both") (picked "") ))
)


;fantasy branch

(defrule fairy-tale
    ?odp <- (genre "Fantasy")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>

    (modify ?wiad (picked "asked"))
    (assert (pytanie (name "fairy-tale") (question "Up for a fairy tale?") (answers "Yes, why mess with classic formula" "No, something more gritty") (picked "")))
)

(defrule classic-preference
    ?odp <- (fairy-tale "Yes, why mess with classic formula")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (assert (pytanie (name "classic-preference") (question "Which of the classics do you prefer?") (answers "A gritty, existential fable" "Reverse Rumpelstiltskin" "Goblin Politics" "A short story") (picked "")))
)

(defrule gritty-fable-result
    ?odp <- (classic-preference "A gritty, existential fable")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (assert (book (author "Kazuo Ishiguro") (title "The Buried Giant")))
)

(defrule rumpelstiltskin-result
    ?odp <- (classic-preference "Reverse Rumpelstiltskin")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Naomi Novik") (title "Spinning Silver")))
)

(defrule goblin-politics-result
    ?odp <- (classic-preference "Goblin Politics")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Katherine Addison") (title "The Goblin Emperor")))
)

(defrule short-story
    ?odp <- (classic-preference "A short story")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (assert (pytanie (name "short-story") (question "The short story should be:") (answers "Based in Asian folklore" "Provocative yet surreal") (picked "")))
)

(defrule asian-folklore-result
    ?odp <- (short-story "Based in Asian folklore")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Ken Liu") (title "The Paper Menagerie And Other Stories")))
)

(defrule provocative-surreal-result
    ?odp <- (short-story "Provocative yet surreal")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Carmen Maria Machado") (title "Her Body and Other Parties")))
)


(defrule society-change
    ?odp <- (fairy-tale "No, something more gritty")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (assert (pytanie (name "society-change") (question "Society on the brink of change?") (answers "Yes, bring on the new world" "No, not that gritty") (picked "")))
)

(defrule land-change
    ?odp <- (society-change "Yes, bring on the new world" )
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (assert (pytanie (name "land-change") (question "What's changing the land?") (answers "Once in an age events" "Magical Revolution") (picked "")))
)


(defrule age-events
    ?odp <- (land-change "Once in an age events")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (assert (pytanie (name "age-events") (question "What events change the land?") (answers "Geological and caste upheaval" "Celestial events in an unbalanced world") (picked "")))
)

(defrule geo-caste-upheaval-result
    ?odp <- (age-events "Geological and caste upheaval")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "N.K. Jemisin") (title "The Fifth Season")))
)

(defrule celestial-events-result
    ?odp <- (age-events "Celestial events in an unbalanced world")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Rebecca Roanhorse") (title "Black Sun")))
)

(defrule magical-revolution
    ?odp <- (land-change "Magical Revolution")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (assert (pytanie (name "magical-revolution") (question "How is magic changing the world?") (answers "A monopoly over magical jade" "New magic and ghostly intrigue" "Magic giving way to machines") (picked "")))
)

(defrule jade-monopoly-result
    ?odp <- (magical-revolution "A monopoly over magical jade")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Fonda Lee") (title "Jade City")))
)

(defrule ghostly-intrigue-result
    ?odp <- (magical-revolution "New magic and ghostly intrigue")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Sofia Samatar") (title "A Stranger un Olondria")))
)

(defrule machines-result
    ?odp <- (magical-revolution "Magic giving way to machines")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Joe Abercrombie") (title "A Little Haterd")))
)



(defrule show-running
    ?odp <- (society-change "No, not that gritty")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "show-running") (question "Who's running the show?") (answers "The Gods" "The People") (picked "")))
)

(defrule gods-involvement
    ?odp <- (show-running "The Gods")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "gods-involvement") (question "How are the gods involved?") (answers "Gods cohabiting hosts" "Gods being overthrowed" "Gods among us") (picked "")))
)

(defrule gods-cohabiting-result
    ?odp <- (gods-involvement "Gods cohabiting hosts")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "R.T.Kuang") (title "The Poppy War")))
)

(defrule overthrowed-gods-result
    ?odp <- (gods-involvement "Gods being overthrowed")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Robert Jackson Bennet") (title "City of Stairs")))
)

(defrule gods-among-us
    ?odp <- (gods-involvement "Gods among us")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "gods-among-us") (question "In what way are gods among us?") (answers "The Odyssey from a goddess' point of view" "Creating a utopia" "With shapeshifters") (picked "")))
)

(defrule odyssey-result
    ?odp <- (gods-among-us "The Odyssey from a goddess' point of view")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Madeline Miller") (title "Circe")))
)

(defrule utopia-result
    ?odp <- (gods-among-us "Creating a utopia")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Jo Walton") (title "The Just City")))
)

(defrule shapeshifters-result
    ?odp <- (gods-among-us "With shapeshifters")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Marlon James") (title "Black Leopard, Red Wolf")))
)

(defrule travel
    ?odp <- (show-running "The People")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "travel") (question "Want to travel somewhere?") (answers "Yes, to a time in the past" "Yes, to somewhere with magical borders" "No") (picked "")))
)

(defrule no-travel-result
    ?odp <- (travel "No")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Seanan McGuire") (title "Every Heart A Doorway")))
)

(defrule in-past
    ?odp <- (travel "Yes, to a time in the past")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "in-past") (question "What kind of place in the past?") (answers "Egypt steeped in magic" "With a magic swindler" "With a magic mapmaker") (picked "")))
)


(defrule travel-past-egipy-result
    ?odp <- (in-past "Egypt steeped in magic")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "P. Djeli Clark") (title "A Master of Djinn")))
)

(defrule magic-swindler-result
    ?odp <- (in-past "With a magic swindler")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "S.A. Chakraborty") (title "The City of Brass")))
)

(defrule magic-mapmaker-result
    ?odp <- (in-past "With a magic mapmaker")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "G. Willow Wilson") (title "The Bird King")))
)

(defrule magical-borders
    ?odp <- (travel "Yes, to somewhere with magical borders")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "magical-borders") (question "Are you sure you want magical borders?") (answers "Perhaps?" "Yes, bring on the new world") (picked "")))
)

(defrule perhaps-magical-borders-result
    ?odp <- (magical-borders "Perhaps?")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Susanna Clarke") (title "Piranesi")))
)

(defrule new-world
    ?odp <- (magical-borders "Yes, bring on the new world")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "new-world") (question "Where do you want to go?") (answers "To other Earths" "To find why magic dried up" "To a magical New York City") (picked "")))
)

(defrule other-earths-result
    ?odp <- (new-world "To other Earths")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "V.E.Schwab") (title "A Darker Shade of Magic")))
)

(defrule magic-dried-up-result
    ?odp <- (new-world "To find why magic dried up")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Zen Cho") (title "Sorcerer to the Crown")))
)

(defrule magical-NY-result
    ?odp <- (new-world "To a magical New York City")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Victor LaValle") (title "The Changeling")))
)

;both branch

(defrule genre-mix-preference
    ?odp <- (genre "A little bit of both")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "genre-mix-preference") (question "Which do you prefer?") (answers "A bit of horror" "Alternative history") (picked "")))
)

(defrule horror
    ?odp <- (genre-mix-preference "A bit of horror")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "horror") (question "What type of horror?") (answers "Dark and omnious" "Religious horror in space") (picked "")))
)

(defrule horror-dark-result
    ?odp <- (horror "Dark and omnious")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Silvia Moreno-Garcia") (title "Mexican Gothic")))
)

(defrule horror-in-space-result
    ?odp <- (horror "Religious horror in space")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Tamsyn Muir") (title "Gideon The Ninth")))
)

(defrule alternative-history
    ?odp <- (genre-mix-preference "Alternative history")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "alternative-history") (question "Where should the alternative history take place?") (answers "In the past" "In the present" "In the future") (picked "")))
)

(defrule alternative-in-past-result
    ?odp <- (alternative-history "In the past")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Robinette Kowal") (title "The Calculating Stars")))
)


(defrule pandemic-too-soon
    ?odp <- (alternative-history "In the present")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "pandemic-too-soon") (question "Too soon for a pandemic?") (answers "Yes" "No") (picked "")))
)

(defrule pandemic-result
    ?odp <- (pandemic-too-soon "No")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Emily St. John Mandel") (title "Station Eleven")))
)

(defrule instead-of-pandemic
    ?odp <- (pandemic-too-soon "Yes")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "instead-of-pandemic") (question "Which would you rather do?") (answers "Escape political unrest" "Start a revolution") (picked "")))
)

(defrule political-unrest-result
    ?odp <- (instead-of-pandemic "Escape political unrest")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "E. Lily Yu") (title "On Fragile Waves")))
)

(defrule revolution-result
    ?odp <- (instead-of-pandemic "Start a revolution")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Tochi Onyebuchi") (title "Riot Baby")))
)

(defrule fighting-in-the-future
    ?odp <- (alternative-history "In the future")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "fighting-in-the-future") (question "What would you rather fight?") (answers "Imperialism" "Climate change") (picked "")))
)

(defrule imperialism-result
    ?odp <- (fighting-in-the-future "Imperialism")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Seth Dickinson") (title "The Traitor Baru Cormorant")))
)

(defrule climate-change-result
    ?odp <- (fighting-in-the-future "Climate change")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Omar El Akkad") (title "American War")))
)

; sci-fi branch

(defrule travel-planets
    ?odp <- (genre "Sci-Fi")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "travel-planets") (question "Want to travel to other planets?") (answers "Yes. Other planets it is" "No. Let's stay on Earth") (picked "")))
)

(defrule stay-on-earth
    ?odp <- (travel-planets "No. Let's stay on Earth")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "stay-on-earth") (question "Today, or an ultra-modern future?") (answers "Focus on today" "Bring on the future" "Why not both?") (picked "")))
)

(defrule bring-feature
    ?odp <- (stay-on-earth "Bring on the future")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "bring-feature") (question "What should the future look like?") (answers "Humans escaping" "Humanity struggling") (picked "")))
)

(defrule human-escape
    ?odp <- (bring-feature "Humans escaping")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "human-escape") (question "Where do people escape to?") (answers "Through the multiverse" "To where time travel is weaponized") (picked "")))
)

(defrule multiverse-result
    ?odp <- (human-escape "Through the multiverse")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Micaiah Johnson") (title "The Space Between Worlds")))
)

(defrule time-travel-result
    ?odp <- (human-escape "To where time travel is weaponized")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Amal El-Mohtar and Max Gladstone") (title "This Is How You Lose the Time War")))
)

(defrule humanity-struggling
    ?odp <- (bring-feature "Humanity struggling")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "humanity-struggling") (question "What are the consequences of the problems?") (answers "We're ready to rebuild" "We've become refugees") (picked "")))
)

(defrule ready-to-rebuild-result
    ?odp <- (humanity-struggling "We're ready to rebuild")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Jeff VaderMeer") (title "Anihilation")))
)

(defrule refugees-result
    ?odp <- (humanity-struggling "We've become refugees")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Tade Thompson") (title "Rosewater")))
)

(defrule focus-on-today-result
    ?odp <- (stay-on-earth "Focus on today")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Sarah Gailey") (title "The Echo Wife")))
)

(defrule why-not-both-result
    ?odp <- (stay-on-earth "Why not both?")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Ted Chiang") (title "Exhalation")))
)

(defrule other-planets
    ?odp <- (travel-planets "Yes. Other planets it is")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "other-planets") (question "Where should the another planet be?") (answers "Let's start closer to home" "Let's go to another galaxy") (picked "")))
)

(defrule another-galaxy
    ?odp <- (other-planets "Let's go to another galaxy")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "another-galaxy") (question "Why do we go to a different galaxy?") (answers "To explore" "To settle down") (picked "")))
)

(defrule explore-with-AI
    ?odp <- (another-galaxy "To explore")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "explore-with-AI") (question "Do you want to explore with sentient AIs?") (answers "Yes" "No, explore nature") (picked "")))
)

(defrule without-AI-result
    ?odp <- (explore-with-AI "No, explore nature")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Yoon Ha Lee") (title "Ninefox Gambit")))
)

(defrule sentient-ai
    ?odp <- (explore-with-AI "Yes")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "sentient-ai") (question "What kind of AI?") (answers "Addicted to TV shows" "With a hive mind") (picked "")))
)

(defrule addicted-tv-result
    ?odp <- (sentient-ai "Addicted to TV shows")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Martha Wells") (title "All Systems Red")))
)

(defrule hive-mind-result
    ?odp <- (sentient-ai "With a hive mind")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Ann Leckie") (title "Ancillary Justice")))
)

(defrule settle-down
    ?odp <- (another-galaxy "To settle down")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "settle-down") (question "Settle down where?") (answers "At the finest off-world university" "On another planet ruled by someone") (picked "")))
)

(defrule finest-university-result
    ?odp <- (settle-down "At the finest off-world university")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Nnedi Okorafor") (title "Binti")))
)

(defrule planet-ruled-by
    ?odp <- (settle-down "On another planet ruled by someone")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "planet-ruled-by") (question "Who should rule the planet?") (answers "Empires inspired by the past" "Intelligent spiders uplifted by science") (picked "")))
)

(defrule empires-inspired-result
    ?odp <- (planet-ruled-by "Empires inspired by the past")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Arkady Martine") (title "A Memory Called Empire")))
)

(defrule intelligent-spiders-result
    ?odp <- (planet-ruled-by "Intelligent spiders uplifted by science")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Adrian Tchaikovsky") (title "Children of Time")))
)

(defrule closer-home
    ?odp <- (other-planets "Let's start closer to home")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "closer-home") (question "What to do closer to home?") (answers "Let the action come to us" "See where adventure leads") (picked "")))
)
    
(defrule action-come-to-us
    ?odp <- (closer-home "Let the action come to us")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "action-come-to-us") (question "Which do you prefer?") (answers "A brewing war with alien tech" "A documentary about a colony's last survivor" "First contact through a VR game") (picked "")))
)

(defrule brewing-war-result
    ?odp <- (action-come-to-us "A brewing war with alien tech")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "James S.A. Corey") (title "Leviathan Wakes")))
)

(defrule documentary-result
    ?odp <- (action-come-to-us "A documentary about a colony's last survivor")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Catherynne M. Valente") (title "Radiance")))
)

(defrule first-contact-result
    ?odp <- (action-come-to-us "First contact through a VR game")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Cixin Liu") (title "The Three-Body Problem")))
)

(defrule adventure-leads
    ?odp <- (closer-home "See where adventure leads")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "adventure-leads") (question "Where should the adventure lead?") (answers "To explore new worlds, seek out new life, and new civilizations" "To find new home" "To science some shit") (picked "")))
)

(defrule some-shit-result
    ?odp <- (adventure-leads "To science some shit")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Andy Weir") (title "The Martian")))
)

(defrule explore-strange-worlds-result
    ?odp <- (adventure-leads "To explore new worlds, seek out new life, and new civilizations")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Becky Chambers") (title "The Long Way to a Small, Angry Planet")))
)

(defrule find-new-home
    ?odp <- (adventure-leads "To find new home")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
 (assert (pytanie (name "find-new-home") (question "What should your new home be like?") (answers "Using a changing extradimensional field" "On generational ship with a racial divide") (picked "")))
)

(defrule changing-extradimensional-field-result
    ?odp <- (find-new-home "Using a changing extradimensional field")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "John Scalzi") (title "The Collapsing Empire")))
)

(defrule generational-ship-result
    ?odp <- (find-new-home "On generational ship with a racial divide")
    ?wiad <- (pytanie (name ?x) (picked ""))
    =>
    (modify ?wiad (picked "asked"))
    (retract ?odp)
    (assert (book (author "Rivers Solomon") (title "An Unkindness of Ghosts")))
)