"""
update_index.py
---------------
py/, ai/, web/ 폴더의 HTML 파일을 스캔해서
index.html 안의 LESSONS 배열을 자동으로 갱신합니다.

HTML 파일 안에 아래 형식의 주석이 있어야 합니다:
  <!-- meta:subject=파이썬 -->
  <!-- meta:unit=2. 자료형 -->
  <!-- meta:title=튜플(tuple) -->
  <!-- meta:desc=생성, 인덱싱, 패킹, 불변 -->

주석이 없는 파일은 LESSONS에 추가되지 않습니다.
"""

import glob
import os
import re
from datetime import datetime, timezone, timedelta


# ── 설정 ──────────────────────────────────────────────
INDEX_FILE   = 'index.html'
SCAN_FOLDERS = ['py', 'ai', 'web']          # 스캔할 폴더 목록
LESSONS_TAG  = 'LESSONS'                    # index.html 안의 배열 변수명
# ──────────────────────────────────────────────────────


def parse_meta(filepath):
    """HTML 파일에서 <!-- meta:key=value --> 주석을 파싱합니다."""
    meta = {}
    try:
        with open(filepath, encoding='utf-8') as f:
            content = f.read()
        for m in re.finditer(r'<!--\s*meta:(\w+)=([^-]+?)\s*-->', content):
            key   = m.group(1).strip()
            value = m.group(2).strip()
            meta[key] = value
    except Exception as e:
        print(f'  [경고] {filepath} 파싱 실패: {e}')
    return meta


def get_file_date(filepath):
    """파일의 git 커밋 날짜 또는 수정 날짜를 반환합니다 (YYYY-MM-DD)."""
    try:
        import subprocess
        result = subprocess.run(
            ['git', 'log', '-1', '--format=%cI', '--', filepath],
            capture_output=True, text=True
        )
        date_str = result.stdout.strip()
        if date_str:
            return date_str[:10]   # YYYY-MM-DD 앞 10자만
    except Exception:
        pass
    # git 실패 시 파일 수정 시간으로 대체
    mtime = os.path.getmtime(filepath)
    kst   = timezone(timedelta(hours=9))
    return datetime.fromtimestamp(mtime, tz=kst).strftime('%Y-%m-%d')


def build_lesson_entry(filepath, meta):
    """LESSONS 배열 항목 문자열을 만듭니다."""
    url     = filepath.replace('\\', '/')       # Windows 경로 대응
    subject = meta.get('subject', '')
    unit    = meta.get('unit',    '')
    title   = meta.get('title',   os.path.splitext(os.path.basename(filepath))[0])
    desc    = meta.get('desc',    '')
    date    = meta.get('date',    get_file_date(filepath))

    return (
        f"  {{\n"
        f"    subject : \"{subject}\",\n"
        f"    unit    : \"{unit}\",\n"
        f"    title   : \"{title}\",\n"
        f"    desc    : \"{desc}\",\n"
        f"    url     : \"{url}\",\n"
        f"    date    : \"{date}\",\n"
        f"    isNew   : false\n"
        f"  }}"
    )


def collect_lessons():
    """모든 폴더를 스캔해서 lesson 항목 리스트를 반환합니다."""
    entries = []
    for folder in SCAN_FOLDERS:
        files = sorted(glob.glob(f'{folder}/**/*.html', recursive=True))
        for filepath in files:
            meta = parse_meta(filepath)
            if not meta:
                print(f'  [스킵] {filepath} — meta 주석 없음')
                continue
            entry = build_lesson_entry(filepath, meta)
            date  = meta.get('date', get_file_date(filepath))
            entries.append((date, filepath, entry))
            print(f'  [추가] {filepath} ({date})')

    # 날짜 내림차순 정렬 (최신 파일이 배열 앞에 오도록)
    entries.sort(key=lambda x: x[0], reverse=True)
    return [e[2] for e in entries]


def update_index(entries):
    """index.html의 LESSONS 배열 내용을 교체합니다."""
    with open(INDEX_FILE, encoding='utf-8') as f:
        content = f.read()

    # const LESSONS = [ ... ]; 패턴을 찾아 내부만 교체
    pattern = re.compile(
        r'(const\s+' + LESSONS_TAG + r'\s*=\s*\[)(.*?)(\];)',
        re.DOTALL
    )
    match = pattern.search(content)
    if not match:
        print(f'[오류] index.html에서 "const {LESSONS_TAG} = [...]" 패턴을 찾지 못했습니다.')
        return False

    new_body  = '\n' + ',\n'.join(entries) + '\n'
    new_block = match.group(1) + new_body + match.group(3)
    new_content = content[:match.start()] + new_block + content[match.end():]

    with open(INDEX_FILE, 'w', encoding='utf-8') as f:
        f.write(new_content)

    print(f'\n[완료] index.html 갱신 — {len(entries)}개 항목')
    return True


if __name__ == '__main__':
    print('=== update_index.py 시작 ===\n')
    lessons = collect_lessons()
    if lessons:
        update_index(lessons)
    else:
        print('[경고] meta 주석이 있는 HTML 파일을 찾지 못했습니다.')
