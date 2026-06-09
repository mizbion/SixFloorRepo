$ErrorActionPreference = 'Stop'

function Escape-Html([string]$s) {
  if ($null -eq $s) { return '' }
  return $s.Replace('&', '&amp;').Replace('<', '&lt;').Replace('>', '&gt;')
}

$lessons = @(
  @{ n = 4;  file = '04_java_operators_slides.html';        unit = '4. Operators';            title = 'Lesson 04 Operators';                 topic = 'Arithmetic and logical operators' },
  @{ n = 5;  file = '05_java_if_slides.html';               unit = '5. If';                   title = 'Lesson 05 If Statements';             topic = 'if, else if, else' },
  @{ n = 6;  file = '06_java_switch_slides.html';           unit = '6. Switch';               title = 'Lesson 06 Switch';                    topic = 'switch-case branching' },
  @{ n = 7;  file = '07_java_for_slides.html';              unit = '7. For Loop';             title = 'Lesson 07 For Loop';                  topic = 'for loop and accumulators' },
  @{ n = 8;  file = '08_java_while_slides.html';            unit = '8. While Loop';           title = 'Lesson 08 While Loop';                topic = 'while and do-while' },
  @{ n = 9;  file = '09_java_loop_practice_slides.html';    unit = '9. Loop Practice';        title = 'Lesson 09 Loop Practice';             topic = 'nested loop patterns' },
  @{ n = 10; file = '10_java_review1_slides.html';          unit = '10. Review';              title = 'Lesson 10 Integrated Practice';       topic = 'conditions and loops review' },
  @{ n = 11; file = '11_java_array_basic_slides.html';      unit = '11. Arrays 1';            title = 'Lesson 11 Arrays Basic';              topic = 'array basics and traversal' },
  @{ n = 12; file = '12_java_array_advanced_slides.html';   unit = '12. Arrays 2';            title = 'Lesson 12 Arrays Advanced';           topic = 'min, max, count, reverse' },
  @{ n = 13; file = '13_java_method_basic_slides.html';     unit = '13. Methods 1';           title = 'Lesson 13 Methods Basic';             topic = 'method declaration and return' },
  @{ n = 14; file = '14_java_method_advanced_slides.html';  unit = '14. Methods 2';           title = 'Lesson 14 Methods Advanced';          topic = 'overloading and refactoring' },
  @{ n = 15; file = '15_java_oop_class_object_slides.html'; unit = '15. OOP 1';               title = 'Lesson 15 Class and Object';          topic = 'class, object, constructor' },
  @{ n = 16; file = '16_java_oop_encapsulation_slides.html';unit = '16. OOP 2';               title = 'Lesson 16 Encapsulation';             topic = 'private fields and getters/setters' },
  @{ n = 17; file = '17_java_oop_inheritance_slides.html';  unit = '17. OOP 3';               title = 'Lesson 17 Inheritance';               topic = 'extends and overriding' },
  @{ n = 18; file = '18_java_exception_fileio_slides.html'; unit = '18. Exception and File';  title = 'Lesson 18 Exception and File IO';     topic = 'try-catch and file IO' },
  @{ n = 19; file = '19_java_project_build_slides.html';    unit = '19. Mini Project';        title = 'Lesson 19 Mini Project Build';        topic = 'project build steps' },
  @{ n = 20; file = '20_java_project_present_slides.html';  unit = '20. Presentation';        title = 'Lesson 20 Presentation and Review';   topic = 'demo and retrospective' }
)

$javaDir = 'd:\SixFloorRepo\java'

foreach ($lesson in $lessons) {
  switch ($lesson.n) {
    { $_ -le 6 } {
      $practice = @(
        'public class Main1 { public static void main(String[] args){ int a=10,b=3; System.out.println(a+b); System.out.println(a%b); } }',
        'public class Main2 { public static void main(String[] args){ int score=82; if(score>=80) System.out.println("PASS"); } }',
        'public class Main3 { public static void main(String[] args){ int level=2; switch(level){ case 1:System.out.println("BEGIN"); break; case 2:System.out.println("MID"); break; default:System.out.println("ADV"); } } }',
        'public class Main4 { public static void main(String[] args){ boolean a=true,b=false; System.out.println(a || b); } }',
        'public class Main5 { public static void main(String[] args){ int x=5; System.out.println(x>=3 && x<10); } }'
      )
      $homework = @(
        'public class Main6 { public static void main(String[] args){ int n=17; if(n%2==0) System.out.println("EVEN"); else System.out.println("ODD"); } }',
        'public class Main7 { public static void main(String[] args){ int day=3; switch(day){ case 1:System.out.println("MON"); break; case 3:System.out.println("WED"); break; default:System.out.println("OTHER"); } } }',
        'public class Main8 { public static void main(String[] args){ int a=7,b=2; double d=(double)a/b; System.out.println(d); } }',
        'public class Main9 { public static void main(String[] args){ int temp=27; boolean rain=false; if(temp>25 && !rain) System.out.println("OUT"); } }',
        'public class Main10 { public static void main(String[] args){ int money=6000; if(money>=5000) System.out.println("MEAL"); } }'
      )
      break
    }
    { $_ -le 10 } {
      $practice = @(
        'public class Main1 { public static void main(String[] args){ for(int i=1;i<=5;i++) System.out.println(i); } }',
        'public class Main2 { public static void main(String[] args){ int sum=0; for(int i=1;i<=10;i++) sum+=i; System.out.println(sum); } }',
        'public class Main3 { public static void main(String[] args){ int i=1; while(i<=3){ System.out.println(i); i++; } } }',
        'public class Main4 { public static void main(String[] args){ for(int i=1;i<=3;i++){ for(int j=1;j<=i;j++) System.out.print("*"); System.out.println(); } } }',
        'public class Main5 { public static void main(String[] args){ int i=0; while(true){ if(i==3) break; System.out.println(i); i++; } } }'
      )
      $homework = @(
        'public class Main6 { public static void main(String[] args){ int total=0; for(int i=2;i<=20;i+=2) total+=i; System.out.println(total); } }',
        'public class Main7 { public static void main(String[] args){ for(int i=9;i>=1;i--) System.out.println(i); } }',
        'public class Main8 { public static void main(String[] args){ int i=0; do{ System.out.println(i); i++; }while(i<3); } }',
        'public class Main9 { public static void main(String[] args){ for(int i=1;i<=20;i++) if(i%3==0) System.out.println(i); } }',
        'public class Main10 { public static void main(String[] args){ for(int i=1;i<=3;i++){ for(int j=1;j<=3;j++) System.out.println(i+","+j); } } }'
      )
      break
    }
    { $_ -le 12 } {
      $practice = @(
        'public class Main1 { public static void main(String[] args){ int[] a={10,20,30}; System.out.println(a[0]); } }',
        'public class Main2 { public static void main(String[] args){ int[] a={2,4,6,8}; int sum=0; for(int n:a) sum+=n; System.out.println(sum); } }',
        'public class Main3 { public static void main(String[] args){ int[] a={9,3,7,5}; int max=a[0]; for(int n:a) if(n>max) max=n; System.out.println(max); } }',
        'public class Main4 { public static void main(String[] args){ int[] a={9,3,7,5}; int min=a[0]; for(int n:a) if(n<min) min=n; System.out.println(min); } }',
        'public class Main5 { public static void main(String[] args){ int[][] m={{1,2},{3,4}}; System.out.println(m[1][0]); } }'
      )
      $homework = @(
        'public class Main6 { public static void main(String[] args){ int[] score={80,90,70}; int s=0; for(int n:score) s+=n; System.out.println(s/3.0); } }',
        'public class Main7 { public static void main(String[] args){ int[] a={1,2,1,3,1}; int cnt=0; for(int n:a) if(n==1) cnt++; System.out.println(cnt); } }',
        'public class Main8 { public static void main(String[] args){ int[] a={10,20,30,40}; for(int i=a.length-1;i>=0;i--) System.out.println(a[i]); } }',
        'public class Main9 { public static void main(String[] args){ String[] n={"A","B","C"}; System.out.println(n.length); } }',
        'public class Main10 { public static void main(String[] args){ int[] a=new int[3]; a[0]=7; a[1]=8; a[2]=9; System.out.println(a[2]); } }'
      )
      break
    }
    { $_ -le 14 } {
      $practice = @(
        'public class Main1 { static int add(int a,int b){ return a+b; } public static void main(String[] args){ System.out.println(add(3,5)); } }',
        'public class Main2 { static void hello(){ System.out.println("hello"); } public static void main(String[] args){ hello(); } }',
        'public class Main3 { static int add(int a,int b,int c){ return a+b+c; } public static void main(String[] args){ System.out.println(add(1,2,3)); } }',
        'public class Main4 { static double add(double a,double b){ return a+b; } public static void main(String[] args){ System.out.println(add(1.5,2.5)); } }',
        'public class Main5 { static boolean even(int n){ return n%2==0; } public static void main(String[] args){ System.out.println(even(14)); } }'
      )
      $homework = @(
        'public class Main6 { static int square(int n){ return n*n; } public static void main(String[] args){ System.out.println(square(6)); } }',
        'public class Main7 { static int max(int a,int b){ return a>b?a:b; } public static void main(String[] args){ System.out.println(max(7,9)); } }',
        'public class Main8 { static String greet(String n){ return "Hi, "+n; } public static void main(String[] args){ System.out.println(greet("Jin")); } }',
        'public class Main9 { static int total(int[] a){ int s=0; for(int n:a) s+=n; return s; } public static void main(String[] args){ int[] x={1,2,3}; System.out.println(total(x)); } }',
        'public class Main10 { static void printName(String n){ System.out.println(n); } public static void main(String[] args){ printName("Min"); } }'
      )
      break
    }
    { $_ -le 17 } {
      $practice = @(
        'class Student1 { String name; Student1(String n){name=n;} } public class Main1 { public static void main(String[] args){ Student1 s=new Student1("Min"); System.out.println(s.name); } }',
        'class Lamp2 { boolean on=false; void toggle(){ on=!on; } } public class Main2 { public static void main(String[] args){ Lamp2 l=new Lamp2(); l.toggle(); System.out.println(l.on); } }',
        'class Account3 { private int money; public void setMoney(int m){ if(m>=0) money=m; } public int getMoney(){ return money; } } public class Main3 { public static void main(String[] args){ Account3 a=new Account3(); a.setMoney(5000); System.out.println(a.getMoney()); } }',
        'class Animal4 { void sound(){ System.out.println("..."); } } class Dog4 extends Animal4 { @Override void sound(){ System.out.println("BOW"); } } public class Main4 { public static void main(String[] args){ new Dog4().sound(); } }',
        'class Shape5 { void draw(){ System.out.println("shape"); } } class Circle5 extends Shape5 { @Override void draw(){ System.out.println("circle"); } } public class Main5 { public static void main(String[] args){ Shape5 s=new Circle5(); s.draw(); } }'
      )
      $homework = @(
        'class User6 { private String id; public void setId(String i){ if(i.length()>=4) id=i; } public String getId(){ return id; } } public class Main6 { public static void main(String[] args){ User6 u=new User6(); u.setId("abcd"); System.out.println(u.getId()); } }',
        'class Parent7 { Parent7(){ System.out.println("parent"); } } class Child7 extends Parent7 { Child7(){ super(); System.out.println("child"); } } public class Main7 { public static void main(String[] args){ new Child7(); } }',
        'class Person8 { String name; } class Teacher8 extends Person8 { String subject; } public class Main8 { public static void main(String[] args){ Teacher8 t=new Teacher8(); t.name="Kim"; t.subject="Java"; System.out.println(t.name+"-"+t.subject); } }',
        'class Product9 { private String name; Product9(String n){name=n;} public String getName(){ return name; } } public class Main9 { public static void main(String[] args){ Product9 p=new Product9("Keyboard"); System.out.println(p.getName()); } }',
        'class Person10 { void info(){ System.out.println("person"); } } class Student10 extends Person10 { @Override void info(){ System.out.println("student"); } } public class Main10 { public static void main(String[] args){ new Student10().info(); } }'
      )
      break
    }
    18 {
      $practice = @(
        'public class Main1 { public static void main(String[] args){ try{ int x=10/0; } catch(ArithmeticException e){ System.out.println("divide by zero"); } } }',
        'public class Main2 { public static void main(String[] args){ try{ String s=null; System.out.println(s.length()); } catch(NullPointerException e){ System.out.println("null error"); } } }',
        'public class Main3 { public static void main(String[] args){ try{ System.out.println("work"); } finally{ System.out.println("done"); } } }',
        'import java.io.*; public class Main4 { public static void main(String[] args) throws Exception { FileWriter fw=new FileWriter("memo.txt"); fw.write("java"); fw.close(); } }',
        'import java.io.*; public class Main5 { public static void main(String[] args) throws Exception { BufferedReader br=new BufferedReader(new FileReader("memo.txt")); System.out.println(br.readLine()); br.close(); } }'
      )
      $homework = @(
        'public class Main6 { public static void main(String[] args){ try{ int[] a={1,2}; System.out.println(a[2]); } catch(ArrayIndexOutOfBoundsException e){ System.out.println("index error"); } } }',
        'public class Main7 { public static void main(String[] args){ try{ Integer.parseInt("A"); } catch(NumberFormatException e){ System.out.println("number format error"); } } }',
        'import java.io.*; public class Main8 { public static void main(String[] args) throws Exception { FileWriter fw=new FileWriter("log.txt"); fw.write("ok"); fw.close(); } }',
        'import java.io.*; public class Main9 { public static void main(String[] args) throws Exception { BufferedReader br=new BufferedReader(new FileReader("log.txt")); String line=br.readLine(); System.out.println(line); br.close(); } }',
        'public class Main10 { public static void main(String[] args){ try{ System.out.println("start"); } catch(Exception e){ System.out.println("error"); } finally{ System.out.println("finish"); } } }'
      )
      break
    }
    19 {
      $practice = @(
        'public class Main1 { public static void main(String[] args){ System.out.println("1.READ 2.ADD 3.EXIT"); } }',
        'class Item2 { String name; int price; Item2(String n,int p){name=n;price=p;} } public class Main2 { public static void main(String[] args){ Item2 i=new Item2("Ramen",4500); System.out.println(i.name); } }',
        'public class Main3 { static int calcTotal(int price,int qty){ return price*qty; } public static void main(String[] args){ System.out.println(calcTotal(3000,2)); } }',
        'public class Main4 { static boolean validQty(int q){ return q>0; } public static void main(String[] args){ System.out.println(validQty(3)); } }',
        'public class Main5 { public static void main(String[] args){ String name="Kimbap"; int price=3500; System.out.println(name+":"+price); } }'
      )
      $homework = @(
        'public class Main6 { static int discount(int total){ return total-500; } public static void main(String[] args){ System.out.println(discount(4500)); } }',
        'public class Main7 { public static void main(String[] args){ int[] orders={2,1,3}; int sum=0; for(int n:orders) sum+=n; System.out.println(sum); } }',
        'class Menu8 { String name; Menu8(String n){name=n;} } public class Main8 { public static void main(String[] args){ Menu8 m=new Menu8("Set"); System.out.println(m.name); } }',
        'public class Main9 { static void printReceipt(String item,int price){ System.out.println(item+" "+price); } public static void main(String[] args){ printReceipt("Soup",6000); } }',
        'public class Main10 { public static void main(String[] args){ System.out.println("Project step done"); } }'
      )
      break
    }
    default {
      $practice = @(
        'public class Main1 { public static void main(String[] args){ System.out.println("Project summary"); } }',
        'public class Main2 { public static void main(String[] args){ int before=3, after=1; System.out.println(before+"->"+after); } }',
        'public class Main3 { static void show(String s){ System.out.println(s); } public static void main(String[] args){ show("Reuse success"); } }',
        'class Presenter4 { String name; Presenter4(String n){name=n;} } public class Main4 { public static void main(String[] args){ Presenter4 p=new Presenter4("Student"); System.out.println(p.name); } }',
        'public class Main5 { public static void main(String[] args){ System.out.println("Next: improve exception handling"); } }'
      )
      $homework = @(
        'public class Main6 { public static void main(String[] args){ System.out.println("Feature list ready"); } }',
        'public class Main7 { public static void main(String[] args){ int fixed=2; System.out.println("fixed="+fixed); } }',
        'public class Main8 { static int score(int a,int b){ return a+b; } public static void main(String[] args){ System.out.println(score(40,45)); } }',
        'public class Main9 { public static void main(String[] args){ String memo="retrospective"; System.out.println(memo); } }',
        'public class Main10 { public static void main(String[] args){ System.out.println("Wrap up"); } }'
      )
    }
  }

  $practiceCards = ''
  foreach ($code in $practice) {
    $practiceCards += '      <div class="card"><div class="mono">' + (Escape-Html $code) + "</div></div>`n"
  }

  $homeworkCards = ''
  foreach ($code in $homework) {
    $homeworkCards += '      <div class="card"><div class="mono">' + (Escape-Html $code) + "</div></div>`n"
  }

  $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- meta:subject=Java -->
<!-- meta:unit=$($lesson.unit) -->
<!-- meta:title=$($lesson.title) -->
<!-- meta:desc=$($lesson.topic) -->
<!-- meta:date=2026-06-09 -->
<title>$($lesson.title)</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=JetBrains+Mono:wght@400;700&display=swap" rel="stylesheet">
<style>
  body{margin:0;font-family:'Noto Sans KR',sans-serif;background:#f4f6fb;color:#1b2440}
  .deck{max-width:980px;margin:0 auto;padding:24px 18px 92px}
  .badge{display:inline-block;border:1px solid #dbe2f1;background:#fff;border-radius:999px;padding:4px 10px;font:11px 'JetBrains Mono',monospace;margin-bottom:12px}
  .slide{display:none;background:#fff;border:1px solid #dbe2f1;border-radius:14px;padding:28px;min-height:520px}
  .slide.active{display:block}
  .grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
  .card{border:1px solid #dbe2f1;border-radius:10px;padding:12px;background:#fff}
  .mono{font:12px 'JetBrains Mono',monospace;background:#1d2330;color:#eef4ff;border-radius:8px;padding:10px;white-space:pre-wrap;line-height:1.7}
  .controls{position:fixed;left:0;right:0;bottom:0;background:#111c2f;color:#fff;padding:10px;display:flex;justify-content:center;gap:8px}
  button{border:none;border-radius:8px;padding:8px 14px;font-weight:700}
  @media(max-width:760px){.grid{grid-template-columns:1fr}}
</style>
</head>
<body>
<div class="deck">
  <span class="badge">JAVA LESSON $($lesson.n)</span>
  <section class="slide active">
    <h1>$($lesson.title)</h1>
    <p>$($lesson.topic)</p>
    <ul>
      <li>Understand key syntax and flow</li>
      <li>Run and verify example outputs</li>
      <li>Practice debugging from errors</li>
    </ul>
  </section>
  <section class="slide">
    <h2>Practice Examples (5)</h2>
    <div class="grid">
$practiceCards    </div>
  </section>
  <section class="slide">
    <h2>Homework Examples (5)</h2>
    <div class="grid">
$homeworkCards    </div>
  </section>
  <section class="slide">
    <h2>Checklist</h2>
    <ul>
      <li>Run 2+ examples and capture output</li>
      <li>Change values and compare behavior</li>
      <li>Record one error and the fix</li>
    </ul>
  </section>
</div>
<div class="controls">
  <button id="prevBtn">Prev</button>
  <span id="counter">1 / 4</span>
  <button id="nextBtn">Next</button>
</div>
<script>
  const slides = Array.from(document.querySelectorAll('.slide'));
  const prevBtn = document.getElementById('prevBtn');
  const nextBtn = document.getElementById('nextBtn');
  const counter = document.getElementById('counter');
  let idx = 0;
  function render(){
    slides.forEach((s,i)=>s.classList.toggle('active',i===idx));
    counter.textContent = (idx+1)+' / '+slides.length;
    prevBtn.disabled = idx===0;
    nextBtn.disabled = idx===slides.length-1;
    window.scrollTo({top:0,behavior:'smooth'});
  }
  prevBtn.addEventListener('click',()=>{ if(idx>0){ idx--; render(); } });
  nextBtn.addEventListener('click',()=>{ if(idx<slides.length-1){ idx++; render(); } });
  document.addEventListener('keydown',(e)=>{ if(e.key==='ArrowLeft') prevBtn.click(); if(e.key==='ArrowRight') nextBtn.click(); });
  render();
</script>
</body>
</html>
"@

  $path = Join-Path $javaDir $lesson.file
  [System.IO.File]::WriteAllText($path, $html, (New-Object System.Text.UTF8Encoding($false)))
  Write-Output "created: $($lesson.file)"
}
