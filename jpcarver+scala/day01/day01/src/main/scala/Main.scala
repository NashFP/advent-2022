import scala.io.Source
import scala.util.{Using, Try, Success, Failure}
@main def main(day: Int, input_file: String): Unit = {  
  readLines(input_file) match
    case Success(lines) => 
      val calories = calories_by_elf(lines)
      run_part(day, calories) match
        case Some(result) => println(result)
        case None => println(s"The value of $day must be either be 1 or 2, not $day")
    case Failure(f) => 
      println(f)
}

def run_part(day: Int, calories: List[Int]) = {
  day match
    case 1 => Some(part1(calories))
    case 2 => Some(part2(calories))
    case _ => None  
}

def part1(calories: List[Int]) = {
  calories.max
}

def part2(calories: List[Int]) = {
  calories
    .sorted(Ordering.Int.reverse)
    .take(3)
    .sum
}

def calories_by_elf(lines: List[String]) = {
  lines.foldLeft(Acc()) { (acc, line) =>
    line match
      case "" =>
        Acc(current = 0, elves = acc.current :: acc.elves)
      case _ =>
        acc.copy(current = acc.current + line.toInt)
  }.elves
}

def readLines(input_file: String): Try[List[String]] =
  Using(Source.fromResource(input_file)) { _.getLines.toList }

case class Acc(current: Int = 0, elves: List[Int] = List[Int]())
