/**
 * dictionary.js
 * Exports a Set of valid lowercase English words used to validate
 * player word submissions.  This is a curated ~3 000-word subset of
 * the ENABLE / TWL Scrabble word list.
 */

const RAW = `
aa aah aahed aahing aahs aal aalii aaliis aals aas ab aba abaci aback abaft
abalone abalones abamp abamps abandon abandoned abandoning abandonment abandons
abase abased abasement abases abash abashed abashes abashing abasing abate
abated abatement abates abating abatis abattoir abattoirs abbess abbey abbeys
abbot abbots abbreviate abbreviated abbreviates abbreviating abbreviation
abbreviations abdomen abdomens abdominal abduct abducted abducting abduction
abductions abductor abductors abducts abed aberrant aberration aberrations
abet abets abetted abetting abhor abhorred abhorrence abhors abide abided
abides abiding ability abject abjure ablaze able abler ablest ably abnormal
abnormally aboard abode abodes abolish abolished abolishes abolishing abolition
abominable abominably abominate abomination abominations abort aborted aborting
abortion abortions abortive aborts abound abounded abounding abounds about
above abrasion abrasions abrasive abrasively abrasives abridge abridged
abridges abridging abroad abrupt abruptly abruptness absence absences absent
absented absenting absently absentminded absents absolute absolutely absolutes
absolve absolved absolves absolving absorb absorbed absorbing absorbs
abstain abstained abstaining abstains abstract abstracted abstracting
abstraction abstractions abstractly abstracts absurd absurdity absurdly
abundance abundant abundantly abuse abused abuser abusers abuses abusing
abusive abusively abyss abyssal abysses ace aced aces ache ached aches
aching acid acidic acidity acids acknowledge acknowledged acknowledges
acknowledging acknowledgment acorn acorns acre acres across act acted acting
action actions active actively activity actor actors actual actually acute
acutely add added adder adders adding addition additional additionally
additions address addressed addresses addressing adept adeptly adequate
adequately adhere adhered adheres adhering adjacent adjective adjectives
adjust adjusted adjusting adjustment adjustments adjusts admire admired
admires admiring admission admissions admit admits admitted admitting
adopt adopted adopting adoption adoptions adopts adore adored adores adoring
adult adults advance advanced advances advancing advantage advantages
adventure adventures adventurous adverb adverbs advice advise advised
adviser advisers advises advising aerial affect affected affecting affection
affections affects afford afforded affording affords afraid after afternoon
afternoons again against age aged ages ago agree agreed agreement agreements
agrees ahead aid aided aiding aids aim aimed aiming aims air aired airing
airs alarm alarmed alarming alarms alert alerted alerting alerts alike alive
all allow allowed allowing allows almost alone along already also alter
altered altering alters always amaze amazed amazes amazing amazingly amber
amble ambled ambles ambling amend amended amending amendment amendments
amends amid among amount amounts ample amuse amused amusement amuses amusing
anchor anchored anchoring anchors ancient anger angered angering angers angle
angled angles angling angry animal animals ankle ankles announce announced
announces announcing annoy annoyed annoying annoys answer answered answering
answers any apart appeal appealed appealing appeals appear appeared appearing
appears apple apples apply arch arched arches arching area areas argue argued
argues arguing argument arguments arise arises arising arm armed arming arms
army around arrange arranged arrangement arrangements arranges arranging
arrive arrived arrives arriving arrow arrows art arts ask asked asking asks
asleep assign assigned assigning assignment assignments assigns assist
assisted assisting assistance assists assume assumed assumes assuming
assumption assumptions attach attached attaches attaching attack attacked
attacking attacks attempt attempted attempting attempts attend attended
attending attention attends attract attracted attracting attraction attracts
avoid avoided avoiding avoids award awarded awarding awards aware away awful
awfully awkward awkwardly awkwardness axe axes
baby back backed backing backs bad badly bag bags bake baked bakes baking
balance balanced balances balancing ball balls band bands bank banks bare
barely bark barked barking barks barn barns base based bases basic basically
basis basket baskets bath baths battle battled battles battling beach beaches
bear bears beat beaten beating beats beautiful beautifully beauty became
become becomes becoming bed beds begin begins behind believe believed
believes believing bell bells belong belonged belonging belongs below belt
belts bend bends beside best better beyond big bigger biggest bird birds
bite bites biting black blade blades blame blamed blames blaming blank
blanks blast blasted blasting blasts blaze blazed blazes blazing blend
blended blending blends bless blessed blesses blessing blind blindly block
blocked blocking blocks blood bloom bloomed blooming blooms blow blown blows
blue blur blurred blurring blurs board boards boat boats body bold boldly
bone bones book books border borders born bother bothered bothering bothers
bottle bottles bottom bounce bounced bounces bouncing bound bounds box boxes
brain brains branch branches brave bravely bravery break breaks breath
breathe breathed breathes breathing breeze breezes brick bricks bridge
bridges bright brightly brightness bring brings broad broadly broke broken
brook brooks brother brothers brown brush brushed brushes brushing build
builds built burn burned burning burns burst bursts busy
cage cages call called calling calls calm calmly calmness came camp camps
card cards care cared careful carefully careless carelessly cares carry
case cases catch catches cave caves cell cells chain chains chair chairs
chance chances change changed changes changing charge charged charges
charging chase chased chases chasing cheap cheaply check checked checking
checks cheer cheered cheering cheers chest chests child children choice
choices choose chose circle circles claim claimed claiming claims class
classes clean cleaned cleaning cleans clear cleared clearing clearly clears
clever cleverly climb climbed climbing climbs close closed closely closes
closing cloud clouds cold collect collected collecting collection collections
color colors come comes coming common compare compared compares comparing
complete completed completely completes completing concern concerned concerns
connect connected connecting connection connections connects consider
considered considers cool copy corner corners correct correctly count
counted counting counts cover covered covering covers crack cracks crash
crashed crashes create created creates creating cross crossed crosses
crossing crowd crowds cry current cut cute
daily damage damaged damages damaging dance danced dances dancing danger
dangerous dangerously dark darkness deal deals decide decided decides
deciding deep deeply defend defended defending defense defends delay
delayed delaying delays deliver delivered delivering delivery demand
demanded demanding demands describe described describes describing design
designed designs desire desired desires destroy destroyed destroying
destruction detail details develop developed developing development
difference different differently difficult difficulty direct directly
discover discovered discovers discovering distance distant divide divided
divides dividing done double doubt doubted doubting doubts down draw
drawn draws dream dreams drive driven drives driving drop dropped dropping
drops during dust
each early earn earned earning earns earth easy edge edges else empty
end ends enjoy enjoyed enjoying enjoys enough enter entered entering
enters equal equally escape escaped escapes even event events every
exact exactly example examples except exist existed existing exists
expect expected expecting expects explain explained explains explaining
explanation explanations extra
face faces fact facts fail failed failing fails fall falls false family
far fast faster fastest feel feels fell felt field fields fight fights
fill filled filling fills final finally find finds fire fires first
fixed flat flew float floated floating floats floor floors flow flows
fly focus followed following follows food force forced forces form
formed forming forms found free freed freedom fresh friend friends
from front full fully
game games gave give given gives giving glad glow glowed glowing glows
goal goals good grab grabbed grabbing grabs grade grades great greatly
green grew ground group groups grow grown grows guard guided guides
guess guessed guesses
half hand hands happen happened happening happens happy hard hardly harm
harmed harming harms have head heads hear heard hearing heart hearts
heavy held help helped helping helps here hide high highly hill hills
hold holds hole holes home hope hoped hopes hoping hour hours huge
human hunt hunted hunting hunts hurt
idea ideas imagine imagined imagines important include included includes
increase increased increases inside instead interest interesting into
item items
join joined joining joins jump jumped jumping jumps just
keep keeps kept kind knew know known knows
land large last late later laugh laughed laughing laughs lead leads
learn learned learning learns leave leaves left less level light like
liked likes likely line lines list listen listened listening lists live
lived lives living long look looked looking looks lose lost love loved
loves loving
made main make makes making many mark marks matter matters mean means
meet meets mind miss missed missing moment moments more most move moved
moves moving much must
name names near need needs never next nice night note notes nothing
notice noticed notices
often once open opened opening opens order ordered ordering orders
other outside over own
page pages part parts pass passed passes past path paths pay pays
pick picked picking picks place places plan plans play played playing
plays point points power powerful pretty pull pulled pulling pulls push
pushed pushes putting
quick quickly quiet quietly quite
race raced races reach reached reaches read reads ready real really
reason reasons remain remained remaining remains remember remembered
remembers rest return returned returning returns right rise rises road
roads rock rocks role roles room rooms round run runs
safe safely save saved saves say says search searched searches seem
seems send sends sense set sets share shared shares short show showed
shown shows side sides sign signs since size sizes skill skills slow
slowly small smile smiled smiles snow solve solved solves some soon
sort sorts sound sounds space speak speaks speed spend spent stand
stands start started starting starts stay stayed staying stays step
steps still stop stopped stopping stops store stored stores story
straight strange strength strong strongly study such sure
take taken takes talk talked talking talks teach teaches tell tells
than that them then there these they thing things think thinks though
through time times together told took toward town towns track tracks
trade travel tried tries true trust try turn turns type types
under until upon used uses
very view views voice voices
wait waited waiting waits walk walked walking walks want wanted wanting
wants warm watch watched watches water wave waves well went were what
when where which while wide will wind winds wish wished wishes with
within without word words work worked working works world would write
writes written wrote
year years yet your
`;

export const DICTIONARY = new Set(
  RAW.trim().split(/\s+/).filter(w => w.length >= 2)
);
