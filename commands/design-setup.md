Guide the user through connecting Stitch MCP for the AI design workflow.

## Steps

### 1. Check Current Status

Check if Stitch MCP is already connected:
```
claude mcp list
```

If `stitch` appears in the list, inform the user it's already connected and ready to use.

### 2. If Not Connected — Guide Setup

Walk the user through these steps:

**Step 1: Get API Key**
1. Go to [stitch.withgoogle.com](https://stitch.withgoogle.com)
2. Sign in with Google account
3. Navigate to MCP settings
4. Copy the API key

**Step 2: Connect MCP**
Tell the user to run this command (they should replace `YOUR_API_KEY` with their actual key):
```
claude mcp add stitch \
  --transport http \
  --url "https://stitch.googleapis.com/mcp" \
  --header "X-Goog-Api-Key: YOUR_API_KEY"
```

**Step 3: Verify**
```
claude mcp list
```
Confirm `stitch` server appears in the list.

### 3. Explain What It Enables

Once connected, explain:

- **UI 작업 시 자동 디자인 단계**: Medium/Large 태스크에서 UI가 포함되면 Stitch가 자동으로 디자인을 생성합니다.
- **5단계 디자인 워크플로우**:
  - Step 0: MCP 연결 확인 (자동)
  - Step 1: AI 디자인 생성 (프롬프트 기반)
  - Step 2: 색상 시스템 추출 (Primary, Semantic, Neutral 등)
  - Step 3: 사용자 피드백 반영
  - Step 4: 디자인 → 코드 핸드오프 (컴포넌트 트리, 디자인 토큰)
- **수동 호출**: 자동 트리거 외에 직접 Stitch MCP 도구를 사용해 디자인 가능

### 4. Available Stitch Tools

연결 후 사용 가능한 도구:
- `create_project` — 새 디자인 프로젝트 생성
- `generate_screen_from_text` — 텍스트로 화면 디자인 생성
- `edit_screens` — 기존 디자인 수정
- `create_design_system` — 디자인 시스템 생성
- `apply_design_system` — 프로젝트에 디자인 시스템 적용
- `generate_variants` — 디자인 변형 생성
- `list_projects` / `get_project` / `list_screens` / `get_screen` — 프로젝트/화면 조회

### 5. Quick Test

Suggest a quick test to verify everything works:
> "Stitch로 간단한 로그인 페이지 디자인 해줘"

If the design generates successfully, setup is complete.

## Rules
- Be patient and guide step by step
- If the user doesn't have a Google account, note that Stitch requires one
- If connection fails, suggest checking firewall/proxy settings
- Don't store or display the user's actual API key in outputs
