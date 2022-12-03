import scala.io.Source
import scala.util.{Using, Try, Success, Failure}

@main def hello: Unit = 
  println("Hello world!")


def part1(input_file: String = "input.txt") = {
  readLines(input_file) match
    case Success(lines) => 
      lines.map(line => {
        val players = line.split(" ")
        val opponent = OpponentSymbol.fromString(players(0))
        val me = MySymbol.fromString(players(1))
        round_score(opponent, me)
      })
    case Failure(f) => f  
}

def round_score(opponent: Symbol, me: Symbol) =
  selection_score(me) + outcome_score(opponent, me)

  
def selection_score(me: Symbol) =
  me match
    case Rock => 1
    case Paper => 2
    case Scissors => 3
   

def outcome_score(opponent: Symbol, me: Symbol) =
  opponent.against(me) match
    case RoundResults.Win => 6
    case RoundResults.Draw => 3
    case RoundResults.Lose => 0
  

def part2(input_file: String = "input.txt") = {
  input_file
}

def readLines(input_file: String): Try[List[String]] =
  Using(Source.fromResource(input_file)) { _.getLines.toList }

object OpponentSymbol {
  def fromString(text: String) =
    text match
      case "A" => Rock
      case "B" => Paper
      case "C" => Scissors
}

object MySymbol {
  def fromString(text: String) =
    text match
      case "X" => Rock
      case "Y" => Paper
      case "Z" => Scissors
}

object RoundResults extends Enumeration {
  type RoundResult
  val Win, Draw, Lose = Value
}

trait Symbol {
  protected val beats: Symbol
  protected val draws: Symbol

  def against(other: Symbol) =
    other match
      case `beats` => RoundResults.Win
      case `draws` => RoundResults.Draw
      case _ => RoundResults.Lose
}

object Rock extends Symbol {
  protected val beats = Scissors
  protected val draws: Symbol = Rock
}

object Paper extends Symbol {
  protected val beats = Rock
  protected val draws = Paper
}

object Scissors extends Symbol {
  protected val beats = Paper
  protected val draws = Scissors
}

