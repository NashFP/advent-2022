import scala.io.Source
import scala.util.{Using, Try, Success, Failure}
import scala.collection.immutable.ArraySeq


@main def hello: Unit = 
  println(part1())
//  println(part2())

def part1(input_file: String = "input.txt") = 
  readLines(input_file) match
    case Success(rucksacks) => 
      rucksacks.foldLeft(0)((acc, r) => 
        val sets = r.map(toValue).splitAt(r.length / 2).toList.map(_.toSet)
        val common = (sets.head & sets.last).head
        acc + common)
    case Failure(f) => f
  

def part2(input_file: String = "input.txt") = 
  readLines(input_file)



def toValue(letter: Char) =
  val code = letter.toInt
  if (letter == letter.toUpper) code - 38 else code - 96


def readLines(input_file: String): Try[List[String]] =
  Using(Source.fromResource(input_file)) { _.getLines.toList }