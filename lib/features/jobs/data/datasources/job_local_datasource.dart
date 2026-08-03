import '../../domain/entities/job_entities.dart';

class JobLocalDataSource {
  List<Company> get _companies => [
        const Company(
          id: 'c1', name: 'Google', logo: 'G',
          industry: 'Technology', size: '10,000+', founded: '1998',
          headquarters: 'Mountain View, CA', website: 'google.com',
          description: 'A multinational technology company focusing on search, cloud, AI, and consumer electronics.',
          techStack: ['Python', 'Java', 'Go', 'Kubernetes', 'TensorFlow', 'Angular'],
          rating: 4.6, reviewCount: 12500, isVerified: true,
        ),
        const Company(
          id: 'c2', name: 'Microsoft', logo: 'M',
          industry: 'Technology', size: '10,000+', founded: '1975',
          headquarters: 'Redmond, WA', website: 'microsoft.com',
          description: 'A global technology corporation developing software, hardware, and cloud services.',
          techStack: ['C#', '.NET', 'TypeScript', 'Azure', 'React', 'PowerShell'],
          rating: 4.5, reviewCount: 10200, isVerified: true,
        ),
        const Company(
          id: 'c3', name: 'Stripe', logo: 'S',
          industry: 'Fintech', size: '1,000-5,000', founded: '2010',
          headquarters: 'San Francisco, CA', website: 'stripe.com',
          description: 'Financial infrastructure for the internet, powering millions of businesses worldwide.',
          techStack: ['Ruby', 'Go', 'React', 'Java', 'Scala'],
          rating: 4.7, reviewCount: 3200, isVerified: true,
        ),
        const Company(
          id: 'c4', name: 'Notion', logo: 'N',
          industry: 'Productivity', size: '500-1,000', founded: '2013',
          headquarters: 'San Francisco, CA', website: 'notion.so',
          description: 'An all-in-one workspace combining notes, docs, wikis, and project management.',
          techStack: ['TypeScript', 'React', 'Node.js', 'PostgreSQL', 'Redis'],
          rating: 4.8, reviewCount: 1800, isVerified: true,
        ),
        const Company(
          id: 'c5', name: 'Netflix', logo: 'N',
          industry: 'Entertainment', size: '5,000-10,000', founded: '1997',
          headquarters: 'Los Gatos, CA', website: 'netflix.com',
          description: 'A leading streaming entertainment service with over 200M subscribers globally.',
          techStack: ['Java', 'Python', 'React', 'AWS', 'Microservices'],
          rating: 4.3, reviewCount: 6700, isVerified: true,
        ),
        const Company(
          id: 'c6', name: 'Airbnb', logo: 'A',
          industry: 'Travel', size: '5,000-10,000', founded: '2008',
          headquarters: 'San Francisco, CA', website: 'airbnb.com',
          description: 'A marketplace for people to list, find, and rent vacation homes and experiences.',
          techStack: ['Ruby on Rails', 'React', 'Swift', 'Kotlin', 'AWS'],
          rating: 4.4, reviewCount: 5100, isVerified: true,
        ),
        const Company(
          id: 'c7', name: 'Figma', logo: 'F',
          industry: 'Design', size: '1,000-5,000', founded: '2012',
          headquarters: 'San Francisco, CA', website: 'figma.com',
          description: 'A collaborative web-based design tool used by teams to create, test, and ship designs.',
          techStack: ['TypeScript', 'C++', 'WebAssembly', 'React', 'Node.js'],
          rating: 4.9, reviewCount: 2100, isVerified: true,
        ),
        const Company(
          id: 'c8', name: 'Shopify', logo: 'S',
          industry: 'E-Commerce', size: '5,000-10,000', founded: '2006',
          headquarters: 'Ottawa, Canada', website: 'shopify.com',
          description: 'A leading commerce platform for starting, growing, and managing a business.',
          techStack: ['Ruby on Rails', 'React', 'GraphQL', 'TypeScript', 'Go'],
          rating: 4.2, reviewCount: 4500, isVerified: true,
        ),
        const Company(
          id: 'c9', name: 'OpenAI', logo: 'O',
          industry: 'Artificial Intelligence', size: '500-1,000', founded: '2015',
          headquarters: 'San Francisco, CA', website: 'openai.com',
          description: 'An AI research company creating safe and beneficial artificial general intelligence.',
          techStack: ['Python', 'PyTorch', 'Kubernetes', 'Rust', 'C++'],
          rating: 4.8, reviewCount: 980, isVerified: true,
        ),
        const Company(
          id: 'c10', name: 'Discord', logo: 'D',
          industry: 'Social', size: '500-1,000', founded: '2015',
          headquarters: 'San Francisco, CA', website: 'discord.com',
          description: 'A Voice over IP and instant messaging platform for gaming and communities.',
          techStack: ['Elixir', 'Rust', 'React', 'TypeScript', 'Python'],
          rating: 4.5, reviewCount: 2800, isVerified: true,
        ),
        const Company(
          id: 'c11', name: 'Atlassian', logo: 'A',
          industry: 'Enterprise Software', size: '10,000+', founded: '2002',
          headquarters: 'Sydney, Australia', website: 'atlassian.com',
          description: 'Provider of collaboration software like Jira, Confluence, and Bitbucket.',
          techStack: ['Java', 'React', 'TypeScript', 'Kotlin', 'GraphQL'],
          rating: 4.3, reviewCount: 7800, isVerified: true,
        ),
        const Company(
          id: 'c12', name: 'Vercel', logo: 'V',
          industry: 'Developer Tools', size: '500-1,000', founded: '2015',
          headquarters: 'San Francisco, CA', website: 'vercel.com',
          description: 'The platform for frontend developers, providing the speed and reliability innovators need.',
          techStack: ['TypeScript', 'Rust', 'React', 'Next.js', 'Node.js'],
          rating: 4.7, reviewCount: 1500, isVerified: true,
        ),
      ];

  List<Job> getJobs() {
    final companies = _companies;
    return [
      Job(
        id: 'j1', title: 'Senior Flutter Developer',
        company: companies[0], location: 'Mountain View, CA',
        description: 'Join the Google Pay team to build beautiful, performant mobile payment experiences for billions of users worldwide. You will work on cross-platform features using Flutter and collaborate with design, product, and backend teams.',
        requirements: ['4+ years of Flutter/Dart development', 'Published apps on Play Store/App Store', 'Strong UI/UX sensibility', 'Experience with state management (Riverpod, Bloc)', 'Firebase integration experience'],
        responsibilities: ['Design and implement new Flutter features', 'Optimize app performance and reduce bundle size', 'Mentor junior developers on best practices', 'Participate in code reviews', 'Collaborate with cross-functional teams'],
        benefits: ['Unlimited PTO', '401k matching', 'Free meals', 'On-site gym', 'Stock options', 'Annual learning budget'],
        skills: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'CI/CD', 'Git'],
        type: JobType.fullTime, experience: JobExperience.senior,
        category: JobCategory.mobile,
        salaryMin: 165000, salaryMax: 210000, salaryCurrency: 'USD',
        postedDate: '2026-07-18', deadline: '2026-08-18',
        isRemote: false, isUrgent: true, applicants: 47,
        aiMatchScore: 94, isSaved: false,
      ),
      Job(
        id: 'j2', title: 'Full Stack Engineer',
        company: companies[1], location: 'Redmond, WA',
        description: 'Build the next generation of Microsoft 365 experiences. Work across the entire stack to deliver enterprise-grade productivity tools used by hundreds of millions of users.',
        requirements: ['3+ years full stack development', 'Proficiency in TypeScript/React and C#/.NET', 'Database design experience', 'Cloud platform knowledge (Azure preferred)', 'Strong problem-solving skills'],
        responsibilities: ['Develop end-to-end features for M365', 'Design scalable microservices', 'Write comprehensive tests', 'Participate in agile ceremonies', 'Contribute to technical documentation'],
        benefits: ['Competitive salary', 'RSU grants', 'Health & dental', 'Employee discount', 'Relocation support'],
        skills: ['TypeScript', 'React', 'C#', '.NET', 'Azure', 'SQL Server'],
        type: JobType.fullTime, experience: JobExperience.mid,
        category: JobCategory.softwareEngineering,
        salaryMin: 130000, salaryMax: 170000, salaryCurrency: 'USD',
        postedDate: '2026-07-15', deadline: '2026-08-15',
        isRemote: true, isUrgent: false, applicants: 132,
        aiMatchScore: 87, isSaved: true,
      ),
      Job(
        id: 'j3', title: 'Product Designer',
        company: companies[2], location: 'San Francisco, CA',
        description: 'Shape the future of internet commerce by designing intuitive payment experiences. Work closely with engineering and product to create interfaces that make complex financial operations simple.',
        requirements: ['3+ years product design experience', 'Expert in Figma', 'Strong portfolio showing end-to-end product design', 'Experience with design systems', 'Understanding of payment flows a plus'],
        responsibilities: ['Lead design for payment products', 'Create wireframes, prototypes, and high-fidelity designs', 'Conduct user research and usability testing', 'Maintain and evolve the design system', 'Present design rationale to stakeholders'],
        benefits: ['Equity compensation', 'Learning stipend', 'Flexible work', 'Parental leave', 'Wellness programs'],
        skills: ['Figma', 'Prototyping', 'User Research', 'Design Systems', 'Interaction Design'],
        type: JobType.fullTime, experience: JobExperience.mid,
        category: JobCategory.design,
        salaryMin: 140000, salaryMax: 185000, salaryCurrency: 'USD',
        postedDate: '2026-07-20', deadline: '2026-08-20',
        isRemote: false, isUrgent: false, applicants: 89,
        aiMatchScore: 72, isSaved: false,
      ),
      Job(
        id: 'j4', title: 'ML Engineer',
        company: companies[8], location: 'San Francisco, CA',
        description: 'Work on cutting-edge AI research and deploy large language models at scale. Join the team pushing the boundaries of artificial intelligence.',
        requirements: ['5+ years ML/AI experience', 'Strong Python and PyTorch skills', 'Experience with distributed training', 'Publications in top-tier ML venues preferred', 'Experience with LLMs and transformer architectures'],
        responsibilities: ['Research and implement new model architectures', 'Optimize model training and inference pipelines', 'Collaborate on safety and alignment research', 'Publish research findings', 'Build internal tooling for ML workflows'],
        benefits: ['Top-tier compensation', 'Research budget', 'Conference attendance', 'Flexible schedule', 'Comprehensive health coverage'],
        skills: ['Python', 'PyTorch', 'Transformers', 'CUDA', 'Distributed Systems', 'Math'],
        type: JobType.fullTime, experience: JobExperience.senior,
        category: JobCategory.aiMl,
        salaryMin: 200000, salaryMax: 350000, salaryCurrency: 'USD',
        postedDate: '2026-07-19', deadline: '2026-08-30',
        isRemote: false, isUrgent: true, applicants: 215,
        aiMatchScore: 65, isSaved: false,
      ),
      Job(
        id: 'j5', title: 'DevOps Engineer',
        company: companies[4], location: 'Los Gatos, CA',
        description: 'Ensure the reliability and scalability of Netflix streaming infrastructure serving 200M+ subscribers globally.',
        requirements: ['4+ years DevOps/SRE experience', 'Expert in AWS services', 'Kubernetes and container orchestration', 'CI/CD pipeline design', 'Terraform/IaC experience'],
        responsibilities: ['Design and maintain deployment pipelines', 'Monitor and optimize system reliability', 'Implement infrastructure as code', 'Respond to production incidents', 'Automate operational tasks'],
        benefits: ['Unlimited vacation', 'Annual bonus', 'Stock options', 'Home office budget', 'Wellness reimbursement'],
        skills: ['AWS', 'Kubernetes', 'Terraform', 'Python', 'Docker', 'Linux'],
        type: JobType.fullTime, experience: JobExperience.senior,
        category: JobCategory.devops,
        salaryMin: 155000, salaryMax: 220000, salaryCurrency: 'USD',
        postedDate: '2026-07-10', deadline: '2026-08-10',
        isRemote: true, isUrgent: false, applicants: 78,
        aiMatchScore: 71, isSaved: false,
      ),
      Job(
        id: 'j6', title: 'iOS Developer',
        company: companies[3], location: 'San Francisco, CA',
        description: 'Build delightful iOS experiences for Notion\'s productivity platform. Work on features used by millions of teams worldwide.',
        requirements: ['3+ years iOS development', 'Swift and SwiftUI proficiency', 'Experience with UIKit and Core Data', 'Understanding of MVVM/Clean Architecture', 'App Store publishing experience'],
        responsibilities: ['Develop new iOS features in Swift/SwiftUI', 'Optimize app performance and memory usage', 'Write unit and integration tests', 'Collaborate with Android team for feature parity', 'Participate in design reviews'],
        benefits: ['Equity package', 'Learning budget', 'Flexible hours', 'Team offsites', 'Mental health support'],
        skills: ['Swift', 'SwiftUI', 'UIKit', 'Core Data', 'Combine', 'Xcode'],
        type: JobType.fullTime, experience: JobExperience.mid,
        category: JobCategory.mobile,
        salaryMin: 140000, salaryMax: 180000, salaryCurrency: 'USD',
        postedDate: '2026-07-17', deadline: '2026-08-17',
        isRemote: true, isUrgent: false, applicants: 63,
        aiMatchScore: 82, isSaved: false,
      ),
      Job(
        id: 'j7', title: 'Data Analyst Intern',
        company: companies[5], location: 'San Francisco, CA',
        description: 'Join Airbnb\'s analytics team to uncover insights that shape the future of travel and hosting experiences.',
        requirements: ['Currently pursuing BS/MS in related field', 'SQL proficiency', 'Experience with Python or R', 'Knowledge of data visualization tools', 'Strong analytical thinking'],
        responsibilities: ['Analyze user behavior data', 'Build dashboards and reports', 'Support product team with data insights', 'Conduct A/B test analysis', 'Document findings and recommendations'],
        benefits: ['Competitive pay', 'Housing stipend', 'Mentorship program', 'Networking events', 'Return offer potential'],
        skills: ['SQL', 'Python', 'Tableau', 'Excel', 'Statistics', 'A/B Testing'],
        type: JobType.internship, experience: JobExperience.entry,
        category: JobCategory.dataScience,
        salaryMin: 45000, salaryMax: 65000, salaryCurrency: 'USD',
        postedDate: '2026-07-20', deadline: '2026-08-05',
        isRemote: false, isUrgent: false, applicants: 342,
        aiMatchScore: 58, isSaved: false,
      ),
      Job(
        id: 'j8', title: 'Backend Engineer',
        company: companies[9], location: 'San Francisco, CA',
        description: 'Build and scale Discord\'s real-time messaging infrastructure handling billions of messages daily.',
        requirements: ['3+ years backend development', 'Proficiency in Elixir, Rust, or Go', 'Experience with real-time systems', 'Database optimization skills', 'Understanding of distributed systems'],
        responsibilities: ['Design scalable backend services', 'Optimize message delivery pipelines', 'Build real-time features', 'Ensure system reliability at scale', 'Mentor junior engineers'],
        benefits: ['Equity compensation', 'Game room', 'Dog-friendly office', 'Health benefits', 'Professional development'],
        skills: ['Elixir', 'Rust', 'Go', 'PostgreSQL', 'Redis', 'gRPC'],
        type: JobType.fullTime, experience: JobExperience.mid,
        category: JobCategory.softwareEngineering,
        salaryMin: 135000, salaryMax: 175000, salaryCurrency: 'USD',
        postedDate: '2026-07-16', deadline: '2026-08-16',
        isRemote: true, isUrgent: false, applicants: 91,
        aiMatchScore: 76, isSaved: false,
      ),
      Job(
        id: 'j9', title: 'Security Engineer',
        company: companies[10], location: 'Remote',
        description: 'Protect Atlassian\'s products and infrastructure from evolving security threats. Build security into every layer of the stack.',
        requirements: ['5+ years security engineering', 'Application security expertise', 'Penetration testing experience', 'Secure code review skills', 'Cloud security knowledge'],
        responsibilities: ['Conduct security assessments', 'Build security automation tools', 'Respond to security incidents', 'Train developers on secure coding', 'Design security architecture'],
        benefits: ['Remote-first culture', 'Stock purchase plan', 'Generous PTO', 'Home office setup', 'Wellness programs'],
        skills: ['Python', 'OWASP', 'Cloud Security', 'SIEM', 'Cryptography', 'Kubernetes'],
        type: JobType.fullTime, experience: JobExperience.senior,
        category: JobCategory.cybersecurity,
        salaryMin: 150000, salaryMax: 200000, salaryCurrency: 'USD',
        postedDate: '2026-07-14', deadline: '2026-08-14',
        isRemote: true, isUrgent: true, applicants: 34,
        aiMatchScore: 45, isSaved: false,
      ),
      Job(
        id: 'j10', title: 'Growth Marketing Manager',
        company: companies[7], location: 'Ottawa, Canada',
        description: 'Drive user acquisition and retention for Shopify\'s merchant platform. Lead data-driven marketing campaigns.',
        requirements: ['4+ years growth marketing', 'Experience with paid acquisition channels', 'Data analysis and attribution modeling', 'A/B testing expertise', 'Strong copywriting skills'],
        responsibilities: ['Plan and execute growth campaigns', 'Analyze funnel metrics and optimize conversion', 'Manage marketing budget and ROI', 'Collaborate with product on activation flows', 'Report on KPIs to leadership'],
        benefits: ['Performance bonus', 'Stock options', 'Remote flexibility', 'Professional development', 'Health & dental'],
        skills: ['Google Ads', 'Facebook Ads', 'Analytics', 'SQL', 'Copywriting', 'A/B Testing'],
        type: JobType.fullTime, experience: JobExperience.mid,
        category: JobCategory.marketing,
        salaryMin: 95000, salaryMax: 130000, salaryCurrency: 'USD',
        postedDate: '2026-07-12', deadline: '2026-08-12',
        isRemote: false, isUrgent: false, applicants: 56,
        aiMatchScore: 52, isSaved: false,
      ),
      Job(
        id: 'j11', title: 'Frontend Engineer',
        company: companies[11], location: 'San Francisco, CA',
        description: 'Build the next generation of developer tools at Vercel. Work on the platform that powers the modern web.',
        requirements: ['3+ years frontend development', 'Expert in React and Next.js', 'TypeScript proficiency', 'Performance optimization experience', 'Open source contributions preferred'],
        responsibilities: ['Build UI components for the Vercel dashboard', 'Optimize web performance metrics', 'Contribute to Next.js open source', 'Design developer-friendly APIs', 'Write technical blog posts'],
        benefits: ['Top-tier compensation', 'All-remote option', 'Open source time', 'Conference budget', 'Latest hardware'],
        skills: ['React', 'Next.js', 'TypeScript', 'Tailwind CSS', 'Node.js', 'Vercel'],
        type: JobType.fullTime, experience: JobExperience.mid,
        category: JobCategory.softwareEngineering,
        salaryMin: 145000, salaryMax: 190000, salaryCurrency: 'USD',
        postedDate: '2026-07-20', deadline: '2026-08-25',
        isRemote: true, isUrgent: false, applicants: 108,
        aiMatchScore: 89, isSaved: false,
      ),
      Job(
        id: 'j12', title: 'UX Researcher',
        company: companies[6], location: 'San Francisco, CA',
        description: 'Conduct research that shapes how designers and developers collaborate in Figma. Help us understand user needs deeply.',
        requirements: ['3+ years UX research experience', 'Mixed methods expertise', 'Experience with enterprise users', 'Strong communication skills', 'Portfolio of research impact'],
        responsibilities: ['Plan and conduct user research studies', 'Synthesize findings into actionable insights', 'Present research to leadership', 'Build research operations', 'Partner with product and design teams'],
        benefits: ['Competitive salary', 'RSUs', 'Flexible PTO', 'Professional development', 'Team building events'],
        skills: ['User Interviews', 'Usability Testing', 'Surveys', 'Data Analysis', 'Figma', 'Notion'],
        type: JobType.fullTime, experience: JobExperience.mid,
        category: JobCategory.design,
        salaryMin: 120000, salaryMax: 160000, salaryCurrency: 'USD',
        postedDate: '2026-07-18', deadline: '2026-08-18',
        isRemote: true, isUrgent: false, applicants: 42,
        aiMatchScore: 61, isSaved: false,
      ),
      Job(
        id: 'j13', title: 'Flutter Developer (Contract)',
        company: companies[3], location: 'Remote',
        description: '6-month contract to build a cross-platform feature for Notion\'s mobile app. High impact, fast-paced project.',
        requirements: ['2+ years Flutter experience', 'Published apps on both platforms', 'Firebase experience', 'Clean architecture knowledge', 'Available for 6 months'],
        responsibilities: ['Build a new cross-platform feature', 'Integrate with existing mobile codebase', 'Write tests and documentation', 'Ship to both app stores', 'Handoff knowledge to full-time team'],
        benefits: ['Competitive hourly rate', 'Flexible schedule', 'Potential conversion', 'Modern tech stack', 'Async communication'],
        skills: ['Flutter', 'Dart', 'Firebase', 'CI/CD', 'Git', 'REST APIs'],
        type: JobType.contract, experience: JobExperience.mid,
        category: JobCategory.mobile,
        salaryMin: 80, salaryMax: 120, salaryCurrency: 'USD',
        postedDate: '2026-07-19', deadline: '2026-07-30',
        isRemote: true, isUrgent: true, applicants: 28,
        aiMatchScore: 91, isSaved: false,
      ),
      Job(
        id: 'j14', title: 'Product Manager',
        company: companies[0], location: 'Mountain View, CA',
        description: 'Lead product strategy for Google Workspace AI features. Drive the vision for how AI transforms productivity.',
        requirements: ['5+ years product management', 'AI/ML product experience', 'Data-driven decision making', 'Technical background preferred', 'Strong cross-functional leadership'],
        responsibilities: ['Define product roadmap and strategy', 'Drive product execution across teams', 'Analyze metrics and user feedback', 'Collaborate with engineering and design', 'Present to senior leadership'],
        benefits: ['Significant equity', 'Annual bonus', 'Sabbatical program', 'On-site amenities', 'Education reimbursement'],
        skills: ['Product Strategy', 'Data Analysis', 'SQL', 'User Research', 'Agile', 'AI/ML'],
        type: JobType.fullTime, experience: JobExperience.senior,
        category: JobCategory.product,
        salaryMin: 175000, salaryMax: 250000, salaryCurrency: 'USD',
        postedDate: '2026-07-15', deadline: '2026-08-15',
        isRemote: false, isUrgent: false, applicants: 89,
        aiMatchScore: 55, isSaved: false,
      ),
      Job(
        id: 'j15', title: 'Junior React Developer',
        company: companies[7], location: 'Remote',
        description: 'Start your career building merchant-facing features at Shopify. Great mentorship and growth opportunities.',
        requirements: ['1+ years React experience', 'JavaScript/TypeScript proficiency', 'HTML/CSS expertise', 'Git knowledge', 'Eagerness to learn'],
        responsibilities: ['Build React components for merchant dashboard', 'Write unit tests', 'Fix bugs and improve performance', 'Participate in code reviews', 'Learn from senior engineers'],
        benefits: ['Mentorship program', 'Learning budget', 'Remote-first', 'Health benefits', 'Stock options'],
        skills: ['React', 'JavaScript', 'TypeScript', 'HTML/CSS', 'Git', 'REST APIs'],
        type: JobType.fullTime, experience: JobExperience.entry,
        category: JobCategory.softwareEngineering,
        salaryMin: 70000, salaryMax: 95000, salaryCurrency: 'USD',
        postedDate: '2026-07-20', deadline: '2026-08-20',
        isRemote: true, isUrgent: false, applicants: 256,
        aiMatchScore: 78, isSaved: false,
      ),
      Job(
        id: 'j16', title: 'Cloud Solutions Architect',
        company: companies[1], location: 'Remote',
        description: 'Design and implement Azure solutions for enterprise customers. Help organizations migrate and modernize their infrastructure.',
        requirements: ['7+ years IT infrastructure', 'Azure certifications', 'Enterprise architecture experience', 'Strong communication skills', 'Consulting background preferred'],
        responsibilities: ['Design cloud architectures', 'Lead migration projects', 'Conduct technical workshops', 'Create architecture documentation', 'Advise customers on best practices'],
        benefits: ['Flexible remote', 'Certification bonuses', 'Sabbatical', 'Health & wellness', 'Stock purchase plan'],
        skills: ['Azure', 'Cloud Architecture', 'Kubernetes', 'Terraform', 'PowerShell', '.NET'],
        type: JobType.fullTime, experience: JobExperience.executive,
        category: JobCategory.devops,
        salaryMin: 165000, salaryMax: 230000, salaryCurrency: 'USD',
        postedDate: '2026-07-13', deadline: '2026-08-13',
        isRemote: true, isUrgent: false, applicants: 45,
        aiMatchScore: 63, isSaved: false,
      ),
      Job(
        id: 'j17', title: 'AI/ML Intern',
        company: companies[8], location: 'San Francisco, CA',
        description: 'Work alongside world-class researchers on projects that push the boundaries of AI capabilities.',
        requirements: ['Currently pursuing MS/PhD in CS or related', 'Strong Python and ML fundamentals', 'Published research a plus', 'Passion for AI safety', 'Available for 12 weeks'],
        responsibilities: ['Assist with research experiments', 'Implement model architectures', 'Analyze experimental results', 'Write research summaries', 'Present findings internally'],
        benefits: ['Top intern compensation', 'Housing stipend', 'Mentorship', 'Conference access', 'Full-time conversion potential'],
        skills: ['Python', 'PyTorch', 'Machine Learning', 'Linear Algebra', 'NLP', 'Research'],
        type: JobType.internship, experience: JobExperience.entry,
        category: JobCategory.aiMl,
        salaryMin: 8000, salaryMax: 12000, salaryCurrency: 'USD',
        postedDate: '2026-07-20', deadline: '2026-08-10',
        isRemote: false, isUrgent: true, applicants: 1890,
        aiMatchScore: 42, isSaved: false,
      ),
      Job(
        id: 'j18', title: 'QA Automation Engineer',
        company: companies[2], location: 'San Francisco, CA',
        description: 'Build and maintain automated testing infrastructure for Stripe\'s payment platform. Ensure reliability for millions of transactions.',
        requirements: ['3+ years QA automation', 'Selenium/Playwright expertise', 'API testing experience', 'CI/CD integration', 'Performance testing skills'],
        responsibilities: ['Design automated test suites', 'Build testing frameworks', 'Integrate tests into CI/CD', 'Report quality metrics', 'Collaborate with developers on testability'],
        benefits: ['Competitive salary', 'Equity', 'Flexible schedule', 'Learning budget', 'Wellness programs'],
        skills: ['Playwright', 'Selenium', 'Python', 'TypeScript', 'API Testing', 'CI/CD'],
        type: JobType.fullTime, experience: JobExperience.mid,
        category: JobCategory.softwareEngineering,
        salaryMin: 115000, salaryMax: 155000, salaryCurrency: 'USD',
        postedDate: '2026-07-16', deadline: '2026-08-16',
        isRemote: true, isUrgent: false, applicants: 67,
        aiMatchScore: 68, isSaved: false,
      ),
      Job(
        id: 'j19', title: 'Technical Writer',
        company: companies[11], location: 'Remote',
        description: 'Create world-class documentation for Vercel\'s developer platform and Next.js framework.',
        requirements: ['2+ years technical writing', 'Web development knowledge', 'Markdown expertise', 'Portfolio of developer docs', 'Experience with docs-as-code workflows'],
        responsibilities: ['Write and maintain API documentation', 'Create tutorial content', 'Improve docs information architecture', 'Collaborate with engineering on releases', 'Contribute to developer blog'],
        benefits: ['Fully remote', 'Flexible hours', 'Open source time', 'Conference budget', 'Generous PTO'],
        skills: ['Technical Writing', 'Markdown', 'React', 'Next.js', 'Git', 'API Design'],
        type: JobType.fullTime, experience: JobExperience.mid,
        category: JobCategory.softwareEngineering,
        salaryMin: 95000, salaryMax: 130000, salaryCurrency: 'USD',
        postedDate: '2026-07-18', deadline: '2026-08-18',
        isRemote: true, isUrgent: false, applicants: 31,
        aiMatchScore: 55, isSaved: false,
      ),
      Job(
        id: 'j20', title: 'Data Engineer',
        company: companies[4], location: 'Los Gatos, CA',
        description: 'Build data pipelines that power Netflix\'s recommendation engine and analytics platform.',
        requirements: ['4+ years data engineering', 'Spark and Kafka expertise', 'SQL mastery', 'Python/Scala proficiency', 'Cloud data platform experience'],
        responsibilities: ['Design and build ETL pipelines', 'Optimize data warehouse performance', 'Build real-time streaming pipelines', 'Ensure data quality and governance', 'Support data science teams'],
        benefits: ['Unlimited PTO', 'Stock options', 'Annual bonus', 'Remote flexibility', 'Wellness fund'],
        skills: ['Apache Spark', 'Kafka', 'SQL', 'Python', 'AWS', 'Airflow'],
        type: JobType.fullTime, experience: JobExperience.senior,
        category: JobCategory.dataScience,
        salaryMin: 155000, salaryMax: 210000, salaryCurrency: 'USD',
        postedDate: '2026-07-11', deadline: '2026-08-11',
        isRemote: true, isUrgent: false, applicants: 73,
        aiMatchScore: 59, isSaved: false,
      ),
      Job(
        id: 'j21', title: 'Part-Time Content Creator',
        company: companies[6], location: 'Remote',
        description: 'Create engaging design tutorials and content for Figma\'s community. Share your design knowledge with millions.',
        requirements: ['Strong Figma skills', 'Content creation experience', 'Social media presence a plus', 'Design portfolio', 'Teaching ability'],
        responsibilities: ['Create Figma tutorial videos', 'Write blog posts about design', 'Engage with the design community', 'Test new Figma features', 'Present at virtual events'],
        benefits: ['Flexible schedule', 'Figma Pro account', 'Hardware provided', 'Community events', 'Creative freedom'],
        skills: ['Figma', 'Video Editing', 'Writing', 'Social Media', 'UI Design', 'Teaching'],
        type: JobType.partTime, experience: JobExperience.mid,
        category: JobCategory.design,
        salaryMin: 35000, salaryMax: 55000, salaryCurrency: 'USD',
        postedDate: '2026-07-20', deadline: '2026-08-15',
        isRemote: true, isUrgent: false, applicants: 187,
        aiMatchScore: 70, isSaved: false,
      ),
      Job(
        id: 'j22', title: 'Senior Backend Engineer',
        company: companies[5], location: 'San Francisco, CA',
        description: 'Scale Airbnb\'s booking platform and build features that connect millions of hosts and guests worldwide.',
        requirements: ['5+ years backend development', 'Ruby on Rails expertise', 'Microservices architecture', 'Performance optimization', 'A/B testing experience'],
        responsibilities: ['Design scalable booking services', 'Optimize API response times', 'Build real-time availability systems', 'Lead technical projects', 'Mentor team members'],
        benefits: ['Equity refresh', 'Travel credits', 'Flexible PTO', 'Parental leave', 'Learning stipend'],
        skills: ['Ruby on Rails', 'Java', 'Kafka', 'MySQL', 'Redis', 'Kubernetes'],
        type: JobType.fullTime, experience: JobExperience.senior,
        category: JobCategory.softwareEngineering,
        salaryMin: 170000, salaryMax: 225000, salaryCurrency: 'USD',
        postedDate: '2026-07-14', deadline: '2026-08-14',
        isRemote: false, isUrgent: false, applicants: 61,
        aiMatchScore: 74, isSaved: false,
      ),
    ];
  }

  List<JobApplication> getApplications() {
    final jobs = getJobs();
    return [
      JobApplication(id: 'a1', job: jobs[1], status: ApplicationStatus.reviewing, appliedDate: '2026-07-10', lastUpdated: '2026-07-18', notes: 'Phone screen completed'),
      JobApplication(id: 'a2', job: jobs[3], status: ApplicationStatus.submitted, appliedDate: '2026-07-19'),
      JobApplication(id: 'a3', job: jobs[5], status: ApplicationStatus.interviewScheduled, appliedDate: '2026-07-05', lastUpdated: '2026-07-17', interviewDate: '2026-07-25'),
      JobApplication(id: 'a4', job: jobs[0], status: ApplicationStatus.shortlisted, appliedDate: '2026-07-12', lastUpdated: '2026-07-20'),
      JobApplication(id: 'a5', job: jobs[10], status: ApplicationStatus.offered, appliedDate: '2026-07-01', lastUpdated: '2026-07-19', notes: 'Offer: \$155k + equity'),
      JobApplication(id: 'a6', job: jobs[14], status: ApplicationStatus.rejected, appliedDate: '2026-06-28', lastUpdated: '2026-07-15'),
    ];
  }

  List<JobAlert> getAlerts() {
    return [
      const JobAlert(id: 'al1', title: 'Flutter Developer Jobs', keywords: 'Flutter, Dart, Mobile', category: JobCategory.mobile, location: 'Remote', isActive: true, createdAt: '2026-07-01', matchCount: 12),
      const JobAlert(id: 'al2', title: 'AI/ML Opportunities', keywords: 'Machine Learning, AI, Python', category: JobCategory.aiMl, location: 'San Francisco', isActive: true, createdAt: '2026-07-05', matchCount: 8),
      const JobAlert(id: 'al3', title: 'Senior Remote Roles', keywords: 'Senior, Remote', minSalary: 150000, isActive: true, createdAt: '2026-07-10', matchCount: 15),
      const JobAlert(id: 'al4', title: 'Design Positions', keywords: 'Product Designer, UX, UI', category: JobCategory.design, isActive: false, createdAt: '2026-06-20', matchCount: 5),
    ];
  }

  SalaryInsight getSalaryInsight(String title) {
    return SalaryInsight(
      title: title,
      average: 145000,
      min: 70000,
      max: 350000,
      p25: 105000,
      p75: 195000,
      byExperience: const [
        SalaryByExperience(experience: 'Entry', salary: 75000),
        SalaryByExperience(experience: 'Mid', salary: 120000),
        SalaryByExperience(experience: 'Senior', salary: 170000),
        SalaryByExperience(experience: 'Lead', salary: 220000),
        SalaryByExperience(experience: 'Executive', salary: 300000),
      ],
      byLocation: const [
        SalaryByLocation(location: 'San Francisco', salary: 175000),
        SalaryByLocation(location: 'New York', salary: 160000),
        SalaryByLocation(location: 'Seattle', salary: 155000),
        SalaryByLocation(location: 'Austin', salary: 125000),
        SalaryByLocation(location: 'Remote (US)', salary: 140000),
        SalaryByLocation(location: 'London', salary: 95000),
      ],
    );
  }

  List<Job> searchJobs(String query, JobFilter filter) {
    var jobs = getJobs();

    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      jobs = jobs.where((j) =>
          j.title.toLowerCase().contains(q) ||
          j.company.name.toLowerCase().contains(q) ||
          j.skills.any((s) => s.toLowerCase().contains(q)) ||
          j.location.toLowerCase().contains(q)).toList();
    }

    if (filter.types.isNotEmpty) {
      jobs = jobs.where((j) => filter.types.contains(j.type)).toList();
    }
    if (filter.experiences.isNotEmpty) {
      jobs = jobs.where((j) => filter.experiences.contains(j.experience)).toList();
    }
    if (filter.categories.isNotEmpty) {
      jobs = jobs.where((j) => filter.categories.contains(j.category)).toList();
    }
    if (filter.remoteOnly) {
      jobs = jobs.where((j) => j.isRemote).toList();
    }
    if (filter.minSalary != null) {
      jobs = jobs.where((j) => j.salaryMax >= filter.minSalary!).toList();
    }
    if (filter.maxSalary != null) {
      jobs = jobs.where((j) => j.salaryMin <= filter.maxSalary!).toList();
    }
    if (filter.location != null && filter.location!.isNotEmpty) {
      final loc = filter.location!.toLowerCase();
      jobs = jobs.where((j) => j.location.toLowerCase().contains(loc)).toList();
    }

    switch (filter.sortBy) {
      case 'salary_high':
        jobs.sort((a, b) => b.salaryMax.compareTo(a.salaryMax));
        break;
      case 'salary_low':
        jobs.sort((a, b) => a.salaryMin.compareTo(b.salaryMin));
        break;
      case 'match':
        jobs.sort((a, b) => b.aiMatchScore.compareTo(a.aiMatchScore));
        break;
      case 'recent':
      default:
        jobs.sort((a, b) => b.postedDate.compareTo(a.postedDate));
    }

    return jobs;
  }

  Company? getCompanyById(String id) {
    try {
      return _companies.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Job> getJobsByCompany(String companyId) {
    return getJobs().where((j) => j.company.id == companyId).toList();
  }

  Job? getJobById(String id) {
    try {
      return getJobs().firstWhere((j) => j.id == id);
    } catch (_) {
      return null;
    }
  }
}
