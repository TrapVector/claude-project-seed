# Question bank

Questions for each stage of `seed/m0-playbook.md`. They're a checklist, not a script: skip what `docs/brief.md` or earlier answers already cover, combine related ones, and ask 3 to 5 at a time. Each chosen profile adds its own questions (see its `PROFILE.md`).

Questions marked **(must)** need an answer before milestone 0 can finish. The rest can be answered with "you decide" or deferred as a numbered open question.

## Stage 0. Orient

- **(must)** Your name as it should appear in the docs (as the owner, and in "Who" on decisions).
- What's your role on this project? (Solo builder, product owner with Claude doing all the code, part of a team?)
- Roughly how much time a week will you spend reviewing? This sets task size and how many sessions run at once.
- How do you want questions: a few at a time with recommendations (default), or longer batches?
- Spelling and tone for docs and anything users read (for example British or US English, plain and short, formal).
- Is anyone else involved who should be named (designers, content authors, testers)?

## Stage 1. Vision and goals

- **(must)** What is it, in one or two sentences?
- **(must)** Who is it for? Who is it not for?
- Why should it exist? What's wrong with what people use today?
- What makes a good experience, in your words? (The moment a user thinks "that's good".)
- **(must)** What does success look like for the first real version, and how will you measure it? (Users, retention, revenue, time saved, "I use it daily".)
- What are you optimising for: learning fast, polish, cost, eventually earning money?
- Constraints: budget for services, deadline, platforms it must run on, tools you already use or refuse to use.
- What is explicitly out of scope, at least for now?
- Is the concept confidential? Should the docs carry a notice?
- Is there anything legal or regulated involved (personal data, payments, health, children, user-generated content)?

## Stage 2. Project type

- What kind of software is it? (Web app, mobile app, desktop app, CLI tool, library or package, backend API or service, data pipeline, browser extension, game, something else.) More than one?
- Where does it run, and who runs it? (Users' browsers, phones, your server, their machines.)
- Does it have a user interface? A visual one?
- Does it need a backend or accounts at first, or can the first version run without one?
- Confirm the profile(s): "<profile> fits because …; OK?"

## Stage 3. Spec

- Walk me through a user's first session, start to finish.
- What are the core rules or behaviours? (Things that must always or never happen.)
- What are the screens, commands or endpoints, and what's on each?
- What states can things be in? (Empty, loading, in progress, done, error, offline.)
- What happens when things go wrong? (Bad input, no network, a failed save, a missing item.)
- What data is kept, where, and for how long? Does any of it identify a person?
- Accessibility needs beyond the defaults (keyboard reachable, colour not the only signal, reduced motion)?
- Performance or size targets? Offline needs?
- Anything visible that needs exact wording you'll want to approve? (Default: Claude proposes, you approve, the agreed copy is recorded.)
- Do you have mockups, a design system or references? Where do they live?

## Stage 4. Contracts and owned content

- Will a person author content the code reads (levels, puzzles, articles, config, translations)? Who, and in what format?
- Should that content be validated automatically? What makes an item invalid?
- Is there a file format, API, schema or message format that should be agreed before coding starts?
- Does anything need versioning or migrations (stored user data, a public API)?
- Do you need an internal tool for authoring content, and in which milestone?

## Stage 5. Tech stack

- Which languages can you read comfortably, if any? (Affects how reviewable the code is for you.)
- Any stack you already know, pay for or want to avoid?
- Hosting: any preference or existing account? Is a free tier enough at first?
- Do you want app-store builds eventually? (Affects whether platform features go through adapters from day one.)
- Package manager and runtime version preferences (default: the profile's).
- Confirm the proposed stack, part by part.

## Stage 6. Workflow and rules

- How will you review each task: preview build on your phone, desktop, reading the diff, screenshots only?
- How many sessions do you want running at once? (Default: up to two until the loop is trusted, then more for tasks marked parallel ok.)
- Beyond the defaults, what must Claude always ask you about?
- What must Claude never do in this project?
- Which folders or files are yours and must not be changed by Claude?
- Model and effort: a default, and which kinds of task get a stronger model?
- Anything you want in every task's final message, beyond the defaults (what changed, PR link, preview link, check results, screenshots checked, decisions needed)?
- Should Claude watch the PR and fix CI failures after opening it? (Default: yes.)

## Stage 7. Before you start

- Which of these do you already have: GitHub account and org, hosting account, domain, app-store developer accounts, payment provider, analytics, error tracking?
- Who pays for each, and is there a spending limit?
- Do you want preview builds for every pull request? (Recommended for anything with a UI.)
- Branch protection on `main` (require a PR)? (Recommended.)
- Which hosts does the cloud environment need to reach beyond package registries? (Each profile lists the usual ones.)
- Any secrets or API keys needed in milestone 1? Where should they live?
- Will you also work locally? On which OS?
- Which real devices will you test on?

## Stage 8. Roadmap

- What's the first version a real person (not you) uses? What must it do, and what can wait?
- What's the riskiest assumption, and how does milestone 1 test it?
- After that: what are the next two or three steps, roughly?
- What result would make you stop, pivot or change course? (This becomes a go/no-go in an exit check.)
- Any dates: a launch, a demo, a deadline?
- When do accounts, payments, ads, analytics or app stores come in, if ever?

## Stage 9. Milestone 1 plan

- Does the order make sense? Anything you want to see earlier, on a preview?
- Are any tasks too big to review in one sitting?
- Which tasks can run in parallel?
- For each task's "Ask first" list: can you answer any now?
- Do you agree with each "Done when"?
