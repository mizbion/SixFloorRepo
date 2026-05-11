/* ============================================================
   lecture_common.js
   모든 차시 공통 기능: 진행바, 프롬프트 복사, 퀴즈, 제출
   각 차시 HTML에서 다음 두 변수만 정의하면 됩니다:
     window.LECTURE_CONFIG = {
       webAppUrl: 'https://script.google.com/...',
       lessonId:  'web/0X_javascript_xxx',
       quizTotal: 10  // 퀴즈 문항 수
     };
   ============================================================ */

(function() {
  // ─── 진행 바 ─────────────────────────────────────
  window.addEventListener('scroll', () => {
    const h = document.documentElement;
    const sc = (h.scrollTop / (h.scrollHeight - h.clientHeight)) * 100;
    const bar = document.getElementById('prog');
    if (bar) bar.style.width = sc + '%';
  });

  // ─── 프롬프트 복사 ───────────────────────────────
  window.copyPrompt = function() {
    const t = document.getElementById('promptText').textContent;
    navigator.clipboard.writeText(t).then(() => {
      const btn = event.target;
      const orig = btn.textContent;
      btn.textContent = '✅ 복사됨!';
      setTimeout(() => btn.textContent = orig, 2000);
    });
  };

  // ─── 퀴즈 시스템 ─────────────────────────────────
  const answered = {};
  let total = 10;  // 기본값, init에서 갱신

  function getTotal() {
    return (window.LECTURE_CONFIG && window.LECTURE_CONFIG.quizTotal) || total;
  }

  window.chk = function(n, correct) {
    const inp = document.getElementById('q' + n);
    const fb = document.getElementById('qf' + n);
    const btn = inp.nextElementSibling;
    const user = inp.value.trim();

    if (!user) {
      fb.textContent = '답을 입력해주세요';
      fb.className = 'qfb ng';
      return;
    }

    const norm = (s) => s.replace(/['"`]/g, '').replace(/[\s,]/g, '').toLowerCase();
    const isOk = norm(user) === norm(correct);

    if (isOk) {
      inp.classList.remove('ing');
      inp.classList.add('iok');
      inp.disabled = true;
      btn.disabled = true;
      fb.textContent = '✅ 정답!';
      fb.className = 'qfb ok';
      answered[n] = { ans: user, ok: true };
    } else {
      inp.classList.add('ing');
      fb.textContent = '❌ 다시 시도해보세요';
      fb.className = 'qfb ng';
      if (!answered[n] || answered[n].ok === false) {
        answered[n] = { ans: user, ok: false };
      }
    }

    updateDashboard();
    updateSummary(n, user, isOk);
    checkSubmit();
  };

  function updateDashboard() {
    const t = getTotal();
    let ok = 0, ng = 0;
    for (const k in answered) {
      if (answered[k].ok) ok++;
      else ng++;
    }
    setText('db-ok', ok);
    setText('db-ng', ng);
    setText('db-done', `${ok}/${t}`);
    setText('db-score', `${ok * Math.round(100/t)}점`);
    const bar = document.getElementById('pbar');
    if (bar) bar.style.width = `${(ok / t) * 100}%`;
  }

  function updateSummary(n, ans, isOk) {
    setText('ans' + n, ans || '-');
    setText('st' + n, isOk ? '✅' : '❌');
  }

  function setText(id, v) {
    const el = document.getElementById(id);
    if (el) el.textContent = v;
  }

  function collectAnswers() {
    const t = getTotal();
    const list = [];
    for (let i = 1; i <= t; i++) {
      if (answered[i]) {
        list.push({ q: i, ans: answered[i].ans, ok: answered[i].ok });
      } else {
        list.push({ q: i, ans: '미응답', ok: false });
      }
    }
    return list;
  }

  window.checkSubmit = function() {
    const t = getTotal();
    const nameEl = document.getElementById('stu-name');
    if (!nameEl) return;
    const name = nameEl.value.trim();
    const allDone = Object.keys(answered).length === t &&
      Object.values(answered).every(a => a.ok);
    const btn = document.getElementById('sub-btn');
    if (btn) btn.disabled = !(name && allDone);
  };

  window.openPopup = function() {
    const t = getTotal();
    const name = document.getElementById('stu-name').value.trim();
    let ok = 0;
    for (const k in answered) if (answered[k].ok) ok++;
    const score = ok * Math.round(100/t);
    let grade;
    if (score >= 90) grade = 'A';
    else if (score >= 80) grade = 'B';
    else if (score >= 70) grade = 'C';
    else if (score >= 60) grade = 'D';
    else grade = 'F';

    setText('p-name', name + ' 학생');
    setText('p-score', score + '점');
    setText('p-grade', grade + ' 등급');
    document.getElementById('popupBg').classList.add('show');
    setText('send-status', '');
  };

  window.closePopup = function() {
    document.getElementById('popupBg').classList.remove('show');
  };

  window.sendAnswers = async function() {
    const t = getTotal();
    const cfg = window.LECTURE_CONFIG || {};
    const name = document.getElementById('stu-name').value.trim();
    let ok = 0;
    for (const k in answered) if (answered[k].ok) ok++;
    const score = ok * Math.round(100/t);
    const status = document.getElementById('send-status');

    status.textContent = '전송 중...';
    try {
      await fetch(cfg.webAppUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'text/plain' },
        body: JSON.stringify({
          lesson: cfg.lessonId,
          name,
          answers: collectAnswers(),
          score: score + '점'
        })
      });
      status.textContent = '✅ 전송 완료!';
    } catch (e) {
      status.textContent = '❌ 전송 실패: ' + e.message;
    }
  };
})();
