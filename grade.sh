
rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission 2> clone-output.txt
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point
#-List-Examples-Greater
#   |-lib
#   |-grading-area
#   |-student-submission
#       |-ListExamples.java
#   |-grade.sh
#   |-GradeServer.java
#   |-Server.java
#   |-TestListExamples.java
# Then, add here code to compile and run, and do any post-processing of the
# tests
# checking if correct files are submitted
if [[ -f student-submission/ListExamples.java ]]
then
  echo "File found"
else 
  echo "File not found"
  exit
fi

# Moving files to grading-area
cp -r student-submission/*.java grading-area
cp -r lib grading-area
cp -r TestListExamples.java grading-area

cd grading-area
CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'
javac -cp $CPATH *.java 2> compile-error.txt
if [[ $? -ne 0 ]]
then
    echo "The program failed to compile"
    echo "The error was"
    echo "$(<compile-error.txt)"
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt
TESTOUT=$(cat junit-output.txt|tail -n 2|head -n 1)
if [[ $TESTOUT == *"OK"* ]]
then
    TESTS=$(echo $TESTOUT|cut -d '(' -f 2|cut -d ' ' -f 1)
    echo "Your score is $TESTS/$TESTS"
else
    REDUCED=$(echo $TESTOUT|grep -o '[0-9:]*')
    TESTS=$(echo $REDUCED|cut -d ':' -f 2)
    FAILURES=$(echo $REDUCED|cut -d ':' -f 3)
    SUCCESS=$((TESTS-FAILURES))
    echo "Your score is $SUCCESS/$TESTS"
fi
