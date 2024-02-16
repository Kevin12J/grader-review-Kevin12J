import static org.junit.Assert.*;
import org.junit.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
  @Test
    public void testFilter(){
        StringChecker sc=new StringChecker() {
            public boolean checkString(String s){
                return s.length()>2;
            }
        };
        List<String> strs=new ArrayList<>();
        strs.add("hi");
        strs.add("hello");
        strs.add("w");
        strs.add("weather");
        strs.add("rain");
        List<String> output=ListExamples.filter(strs,sc);
        int strsTrack=0;
        for(int i=0;i<output.size();i++){
            while(!sc.checkString(strs.get(strsTrack))){
                strsTrack++;
            }
            assertEquals(strs.get(strsTrack),output.get(i));
            strsTrack++;
        }
    }
    
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }
}
