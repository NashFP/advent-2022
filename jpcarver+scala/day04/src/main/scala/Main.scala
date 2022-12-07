import scala.io.Source
import scala.util.{Using, Try, Success, Failure}
import scala.util.matching.Regex
import scala.collection.immutable.HashSet
import scala.util.chaining.scalaUtilChainingOps

// This is a cool solution, too bad it gives wrong results

@main def hello: Unit = 
  println(s"Part 1: ${part1()}")
  println(s"Part 2: ${part2()}")

def part1(input_file: String = "input.txt") =
  run(input_file, isOneASubsetOfTheOther)

def part2(input_file: String = "input.txt") =
  run(input_file, doIntersect)

def run(input_file: String, fn: Seq[Set[Int]] => Boolean) =
    readLines(input_file) match
    case Success(lines) => 
      lines.foldLeft(0)((acc, line) => addOneIfMatch(acc, line, fn))
    case Failure(f) => f

def addOneIfMatch(acc: Int, line: String, fn: Seq[Set[Int]] => Boolean) =
  val pattern: Regex = "\\d{1,2}".r
  pattern
  .findAllIn(line)
  .map(_.toInt)
  .toSeq  
  .grouped(2)
  .map(pair => List.range(pair.head, pair.last).toSet)
  .toSeq
  .pipe(fn)
  .pipe(b => if (b) acc + 1 else acc)

def isOneASubsetOfTheOther(pair: Seq[Set[Int]]): Boolean =
  pair.head.subsetOf(pair.last) || pair.last.subsetOf(pair.head)

def doIntersect(pair: Seq[Set[Int]]): Boolean =
  !(pair.head & pair.last).isEmpty

def readLines(input_file: String): Try[Seq[String]] =
  Using(Source.fromResource(input_file)) { _.getLines.toSeq }