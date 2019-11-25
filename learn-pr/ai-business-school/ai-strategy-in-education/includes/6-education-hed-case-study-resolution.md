## Approach

Within Teams, data was collected and stored from chat and discussion forums, video lecture recordings and transcripts, live-synchronized lecture notes, study guides, assignments, and more. This new wealth of data presented a significant opportunity to innovate with AI. Dr. Kellermann decided to start with two main initiatives: helping his teaching assistants respond to the massive increase in student engagement in Teams and giving students a personalized learning experience despite the large class size.

To address the first objective, Kellermann worked with Microsoft Partner Antares Solutions to build an AI-powered chatbot called QuestionBot. Initially, the bot simply forwarded students’ questions to their TA and then closed the service ticket when an answer was received. It then compiled all the question and answer (Q-A) pairs in a Teams page, generating a resource for students built from each other’s learnings. In the first two weeks alone, QuestionBot logged 200 question and answer pairs.

Then, the team began training QuestionBot to answer questions on its own by using the existing Q-A pairs as training data. Once the bot has seen a question answered by a human, it can answer similar questions automatically the next time they are asked. In addition to the Q-A pairs, QuestionBot’s knowledge base includes class lecture transcripts. This means it can search the transcripts for information relevant to key words in a student’s question, and then link the student to the exact timestamp in the lecture where the topic was discussed.

When QuestionBot provides answers to student questions, it provides a confidence score along with the answer, and the option to report the answer as ‘useful’ or ‘not useful’. This feedback enables the bot to improve over time and makes sure students are presented with the most helpful answers first.

With the implementation of QuestionBot, there were some unforeseen challenges along the way that required creative solutions. For example, many students uploaded photos of their homework asking for help, but with the important information buried in a photo, the bot couldn’t read their questions. To overcome this, a QR code was added to each assigned question. With each QR code corresponding to a question in its knowledge base, QuestionBot could use image recognition to identify the question and point the student to relevant information.

The team’s second objective was to deliver a deeply personalized experience for every student at scale. QuestionBot proved essential to this as well. Kellermann and Antares trained the bot to answer highly personalized questions like “when is my tutorial” and “what are the topics on my next exam.” To achieve this, it has to understand contextual factors such as who the student is and what day they are asking the question and pull information from sources such as the student-tutorial mapping list, exam timetables, and the course outline.

But this was just the beginning. To enable further personalization, data was leveraged from Kellerman’s pilot class to train an AI model to predict student performance on every question, for every exam. With this AI model, QuestionBot could now produce custom study guides for every student in the class. “We automatically assembled 500 individual, personalized, optimized study packs for every student,” notes Kellermann. These packs were “based on the prediction of not only their exam result, but their exam result for every individual question two weeks before sitting it.”<sup>2</sup> These study packs grant students better visibility into where they are strongest, and where they should focus their studies leading up to an exam.

Throughout these implementations, handling private student data responsibly and securely was a high priority for UNSW. Dr. Kellermann and Antares built their systems on a platform that adheres to GDPR compliance and uses end-to-end encryption to protect student data.

## Results

These applications illustrate that AI isn’t just a time-saver. It’s helping UNSW achieve things that were previously impossible. Even with a class of 100 students and a team of teaching assistants, it would be impossible to predict student performance on every exam question, create personalized learning materials, or connect students to peers and instructors at this scale. This is the true power of AI: making it possible to effectively operate at scale.

In doing so, Kellermann and his partners succeeded in creating a better experience for his students and assistants.

For one, his students are more successful on exams. In the pilot class, 85% of students passed their exams—a notable increase from the previous average of 65%.<sup>3</sup>

Additionally, the pilot class reported a 99% satisfaction rate.<sup>4</sup> Perhaps even better, 100% of students reported that they felt like part of a learning community—a key goal from the outset.<sup>4</sup> Much of this positive student feedback can be attributed to the new level of personalized teaching and increased insight into student performance. An increase in satisfaction rate not only benefits students but teaching staff as well, as instructors are often evaluated based on these metrics.

AI has also made life easier for the teaching staff by supporting instruction and enabling students to take ownership of their own learning. Not only does QuestionBot help ensure that every question gets answered, but, Kellermann and his TAs no longer have to answer repetitive questions, allowing them to focus on answering the toughest questions and engaging students face-to-face. The bot has also become a form of “formative assessment” that gives instructors snapshot of how students are progressing.

With the pilot’s resounding success, it should be unsurprising that UNSW has decided to expand the program, more than doubling its size to 1200 students.<sup>5</sup> The university is currently discussing how to infuse AI into more classrooms, and other schools are taking note. UNSW is uncovering opportunities for AI to provide value outside the classroom, such as student services and wellbeing programs, skill development, career planning, and more. Because higher education is such a competitive sector, universities must keep up with innovators like UNSW or they risk getting left behind. If universities want to take advantage of the incredible benefits that AI has to offer, they need to formulate an AI strategy as soon as possible.

## Key lessons

### User error should be expected and planned for

One of the first challenges in this case was user error. For QuestionBot to work properly, students must tag it in their question, but many students forgot to tag it, or tagged it in a response which the bot wasn’t designed to handle. To address this, Antares is updating QuestionBot to respond to students without even being called, purely by recognizing when it’s needed. When implementing AI, think about your processes for identifying and addressing problems. No one gets AI perfectly right the first time, so make sure you have processes in place to enable continuous improvement.

### Good AI requires deep integration, and deep integration requires robust collaboration

For an AI project like this, **everyone** is a stakeholder. To integrate AI effectively, people from every level and department had to participate in this implementation—people from IT and engineering, educational designers and professors, even TAs and employees that run the printing shop. Presenting and contributing to forums, conferences, and lunchtime seminars are some ways to connect with other motivated colleagues. Good AI requires deep integration, and if you really want to integrate something, you have to view everyone as a stakeholder because everyone in the organization either contributes or benefits from the project.

### Start small and with value  

This case study emphasizes the importance of starting small and leading with value. You want to look for ways in which you can add value for every user, every day—what can you offer users that is better than what they currently have? If you want to push for wider AI adoption within your institution or enterprise, your pilot programs need to be used, and they need to be loved. This story also demonstrates the value of starting with a small pilot to demonstrate valuable results, and then scaling up from there.

### Think about your data schema early

When looking to implement AI, you should start thinking about your data schema from the outset of the project. Your AI will only be as good as its training data, so think about how you can structure your data to maximize impact. Even a small amount of structure in the data schema can be a springboard for a successful AI. For example, if you can organize your data by categories such as task, class, week, or project, your AI will be better at correlating events in the form of weighted functions within a neural net or key value pairs in a data model, like mapping “lecture attendance for topic X” to “performance in exam question X.” Planning out your data schema from the start will drive the value of your AI much higher in the long run.

### Evaluation of the strategy using the value framework

Let’s examine how UNSW’s AI strategy is creating additional value using the value creation framework developed by Peter Zemsky, INSEAD’s Eli Lilly Chaired Professor of Strategy and Innovation:

1. From the **environment perspective**, educational institutions are striving to meet the rising demands of digitally-native students and handle growing class sizes. Using AI to help engage students and personalize the learning experience is key to UNSW’s success and serves as a model for other schools and universities.  
2. From the **value creation perspective**, Kellermann saw improved student outcomes, namely, a 99% satisfaction rate, and an 85% exam pass rate in his pilot class. This will generate immense value for UNSW as they strive to become Australia’s leading global university.  
3. From the **organization and execution perspective**, UNSW demonstrates the vital nature of collaboration and choosing the right starting point for complex AI initiatives. UNSW was able to develop and implement AI through close collaboration with Microsoft Partner Antares Solutions and support for AI initiatives from stakeholders across the university. They also started strategically by leveraging the data they were already collecting in Teams to train AI models and building in ways for the models to continuously improve.  

Now that you’ve seen how UNSW is leveraging AI in the classroom to drive student satisfaction and success, let’s wrap up everything you’ve learned with a knowledge check.
