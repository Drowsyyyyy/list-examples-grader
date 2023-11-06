CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
files=`find student-submission`
for file in $files
do
    if [[ -f $file ]] && [[ $file == student-submission/ListExamples.java ]]
    then 
        cp $file grading-area 
        cp TestListExamples.java grading-area
        cp -r lib grading-area
        javac -cp $CPATH grading-area/ListExamples.java grading-area/TestListExamples.java
        cd grading-area
        java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > Test-result.txt
        result1=`grep "OK" Test-result.txt`
        result2=`grep "Failures" Test-result.txt`
        echo $result1
        echo $result2
        exit
    fi
done

echo "Correct file is not detected. You should submit ListExamples.java file."
exit
