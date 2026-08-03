import '../../domain/entities/explore_entities.dart';

class ExploreLocalDataSource {
  final List<ExploreArticle> _articles = [
    const ExploreArticle(
      id: 'ai-1',
      title: 'GPT-5 Rumors: What We Know So Far',
      summary: 'OpenAI is expected to release GPT-5 with multimodal reasoning capabilities.',
      content: 'The AI community is buzzing with anticipation as reports suggest OpenAI is preparing to unveil GPT-5, its next-generation large language model. Sources close to the company indicate that the new model will feature significant improvements in multimodal reasoning, code generation, and factual accuracy.\n\nIndustry analysts predict GPT-5 will set a new benchmark for AI performance, surpassing current models by a substantial margin. The model is expected to handle complex multi-step reasoning tasks with unprecedented accuracy.\n\nOne of the most exciting aspects is the reported ability to process and generate content across text, images, audio, and video simultaneously. This multimodal approach could revolutionize how we interact with AI systems in professional and creative workflows.\n\nHowever, concerns about AI safety and responsible deployment remain at the forefront of discussions. OpenAI has stated that extensive red-teaming and safety evaluations are underway before any public release.',
      author: 'Sarah Chen',
      source: 'TechCrunch',
      publishedAt: '2h ago',
      readTime: 5,
      category: ExploreCategory.ai,
      tags: ['GPT-5', 'OpenAI', 'LLM', 'trending', 'popular'],
    ),
    const ExploreArticle(
      id: 'ai-2',
      title: 'Building RAG Systems with LangChain',
      summary: 'A practical guide to retrieval-augmented generation for enterprise applications.',
      content: 'Retrieval-Augmented Generation (RAG) has become the go-to architecture for building AI applications that need to access and reason over private data. In this article, we explore how to build production-ready RAG systems using LangChain.\n\nThe fundamental concept behind RAG is straightforward: instead of relying solely on the model\'s training data, we retrieve relevant documents from a knowledge base and include them in the prompt context. This dramatically improves accuracy and reduces hallucinations.\n\nLangChain provides a comprehensive toolkit for building RAG pipelines. With its extensive integrations for vector stores like Pinecone, Weaviate, and ChromaDB, you can quickly set up document ingestion, embedding generation, and similarity search.\n\nKey considerations for production RAG systems include chunk size optimization, embedding model selection, reranking strategies, and query transformation techniques. Each of these components significantly impacts the quality of retrieved context and final output.',
      author: 'James Mitchell',
      source: 'Towards AI',
      publishedAt: '5h ago',
      readTime: 8,
      category: ExploreCategory.ai,
      tags: ['RAG', 'LangChain', 'LLM', 'tutorial'],
    ),
    const ExploreArticle(
      id: 'ai-3',
      title: 'The Rise of Local AI Models',
      summary: 'How on-device AI is changing the privacy landscape of machine learning.',
      content: 'The push toward running AI models locally on consumer devices has gained tremendous momentum. From Apple\'s Core ML to Google\'s on-device TensorFlow Lite, major tech companies are investing heavily in edge AI.\n\nLocal AI models offer significant advantages in terms of privacy, latency, and cost. Users no longer need to send sensitive data to cloud servers for processing, which is particularly important in healthcare, finance, and personal productivity applications.\n\nThe llama.cpp project has been a catalyst for local AI adoption, enabling users to run powerful language models on laptops and smartphones. Combined with quantization techniques like GGUF and GPTQ, models with billions of parameters can now run on devices with just 8GB of RAM.\n\nThis shift has profound implications for app development. Developers can now build AI-powered features that work entirely offline, opening up possibilities for applications in areas with limited internet connectivity.',
      author: 'Emily Zhang',
      source: 'MIT Tech Review',
      publishedAt: '1d ago',
      readTime: 6,
      category: ExploreCategory.ai,
      tags: ['edge-ai', 'privacy', 'local-models', 'trending'],
    ),
    const ExploreArticle(
      id: 'prog-1',
      title: 'Rust in 2025: Why Systems Programming Matters',
      summary: 'Rust adoption continues to grow as memory safety becomes a priority.',
      content: 'Rust has cemented its position as the language of choice for systems programming, with adoption expanding far beyond its original domain. The Linux kernel now contains millions of lines of Rust code, and major tech companies are rewriting critical infrastructure in Rust.\n\nThe memory safety guarantees provided by Rust\'s ownership system have proven invaluable in preventing entire classes of security vulnerabilities. The White House and CISA have both recommended memory-safe languages for critical infrastructure.\n\nFor web developers, Rust\'s WASM compilation target opens up performance-critical browser applications. Frameworks like Leptos and Dioxus are making Rust a viable choice for full-stack web development.\n\nLearning Rust remains challenging for newcomers, but the investment pays dividends. The compiler\'s error messages are legendary for their helpfulness, and the ecosystem\'s commitment to documentation and tooling makes the learning curve more manageable than ever.',
      author: 'Alex Rivera',
      source: 'InfoQ',
      publishedAt: '3h ago',
      readTime: 7,
      category: ExploreCategory.programming,
      tags: ['Rust', 'systems-programming', 'memory-safety', 'popular'],
    ),
    const ExploreArticle(
      id: 'prog-2',
      title: 'TypeScript 6.0: Pattern Matching and Beyond',
      summary: 'The latest TypeScript release introduces game-changing language features.',
      content: 'TypeScript 6.0 brings some of the most anticipated features in the language\'s history. Pattern matching, pipe operators, and improved type inference make TypeScript more expressive and powerful than ever.\n\nPattern matching in TypeScript allows developers to destructure and match complex data structures with elegant syntax. This feature, long available in languages like Rust and Swift, finally arrives in the JavaScript ecosystem.\n\nThe new pipe operator enables functional composition patterns that were previously cumbersome in TypeScript. Combined with pattern matching, it opens up entirely new coding styles that improve readability and maintainability.\n\nPerformance improvements in the TypeScript compiler also mean faster build times for large projects. The new incremental compilation pipeline can handle monorepos with millions of lines of code efficiently.',
      author: 'Maria Santos',
      source: 'Dev.to',
      publishedAt: '6h ago',
      readTime: 5,
      category: ExploreCategory.programming,
      tags: ['TypeScript', 'JavaScript', 'language-features', 'trending'],
    ),
    const ExploreArticle(
      id: 'prog-3',
      title: 'WebAssembly Beyond the Browser',
      summary: 'WASI and the component model are making Wasm a universal runtime.',
      content: 'WebAssembly is no longer just a browser technology. The WebAssembly System Interface (WASI) has evolved to enable Wasm modules to run anywhere — from servers and edge functions to IoT devices and blockchain networks.\n\nThe component model proposal for WebAssembly is particularly exciting. It enables different Wasm modules written in different languages to interoperate seamlessly, creating a truly polyglot computing platform.\n\nCloudflare Workers, Fastly Compute, and Fermyon Spin are already leveraging Wasm for serverless computing with near-instant cold start times. This technology is reshaping how we think about cloud computing and application deployment.\n\nFor developers, the implications are significant. Write once in any language, compile to Wasm, and run everywhere with near-native performance. The dream of universal binary compatibility is closer to reality than ever.',
      author: 'Tom Anderson',
      source: 'The New Stack',
      publishedAt: '8h ago',
      readTime: 6,
      category: ExploreCategory.programming,
      tags: ['WebAssembly', 'WASI', 'cross-platform'],
    ),
    const ExploreArticle(
      id: 'cloud-1',
      title: 'Kubernetes Cost Optimization Strategies',
      summary: 'How to reduce your cloud spend by 40% without sacrificing performance.',
      content: 'Cloud costs continue to rise, and Kubernetes clusters are often the biggest line item in engineering budgets. This article covers practical strategies that have helped companies save 40% or more on their Kubernetes infrastructure costs.\n\nThe first step is visibility. Tools like Kubecost and OpenCost provide detailed breakdowns of resource usage by namespace, deployment, and pod. Most teams discover significant waste once they have proper cost allocation.\n\nRight-sizing workloads is the lowest-hanging fruit. Many teams over-provision CPU and memory requests. Using Vertical Pod Autoscaler recommendations and implementing resource quotas can dramatically reduce waste without impacting performance.\n\nSpot instances and preemptible VMs offer the most significant savings for fault-tolerant workloads. Modern Kubernetes distributions make it easy to mix spot and on-demand nodes with intelligent scheduling.',
      author: 'David Park',
      source: 'Kubernetes Blog',
      publishedAt: '4h ago',
      readTime: 9,
      category: ExploreCategory.cloud,
      tags: ['Kubernetes', 'cost-optimization', 'DevOps', 'popular'],
    ),
    const ExploreArticle(
      id: 'cloud-2',
      title: 'Serverless at Scale: Lessons from Production',
      summary: 'Real-world patterns and pitfalls from running serverless at millions of requests.',
      content: 'Running serverless architectures at scale presents unique challenges that differ significantly from traditional server-based deployments. After running millions of Lambda functions daily, here are the key lessons we\'ve learned.\n\nCold starts remain the biggest challenge for latency-sensitive applications. Strategies like provisioned concurrency, SnapStart for Java, and careful function design can minimize their impact. The key is understanding when cold starts actually matter versus when they\'re negligible.\n\nObservability in serverless requires a different mindset. Distributed tracing becomes essential, and tools like AWS X-Ray and Datadog provide visibility across function chains. Structured logging and correlation IDs are non-negotiable.\n\nVendor lock-in is a real concern but often overstated. The Serverless Framework and SST provide abstraction layers, and the core patterns — event-driven functions, managed databases, and API gateways — are similar across providers.',
      author: 'Lisa Wang',
      source: 'AWS Blog',
      publishedAt: '12h ago',
      readTime: 7,
      category: ExploreCategory.cloud,
      tags: ['serverless', 'AWS', 'Lambda', 'architecture'],
    ),
    const ExploreArticle(
      id: 'cloud-3',
      title: 'Multi-Cloud Strategies That Actually Work',
      summary: 'Moving beyond hype to practical multi-cloud architecture patterns.',
      content: 'Multi-cloud is often dismissed as unnecessary complexity, but for many organizations, it provides genuine benefits in resilience, compliance, and cost optimization. The key is being intentional about which workloads go where.\n\nThe most successful multi-cloud strategies focus on using each cloud for its strengths. For example, using GCP for AI/ML workloads, AWS for general compute and storage, and Azure for enterprise integration with Microsoft tools.\n\nInfrastructure abstraction through Terraform, Pulumi, or Crossplane makes multi-cloud manageable. These tools provide consistent APIs across providers while still allowing provider-specific optimizations where needed.\n\nData gravity is the biggest practical challenge. Moving large datasets between clouds is expensive and slow. Designing for data locality and using edge caching strategies are essential for multi-cloud success.',
      author: 'Robert Kim',
      source: 'Cloud Native Computing',
      publishedAt: '1d ago',
      readTime: 8,
      category: ExploreCategory.cloud,
      tags: ['multi-cloud', 'architecture', 'infrastructure'],
    ),
    const ExploreArticle(
      id: 'sec-1',
      title: 'Zero Trust Architecture Implementation Guide',
      summary: 'Step-by-step guide to implementing zero trust security in your organization.',
      content: 'Zero Trust has evolved from a buzzword to a security necessity. With remote work becoming permanent and cloud adoption accelerating, the traditional perimeter-based security model is no longer sufficient.\n\nThe core principle of Zero Trust is simple: never trust, always verify. Every request, regardless of origin, must be authenticated and authorized. This applies to internal traffic as much as external requests.\n\nImplementation typically starts with identity. Strong multi-factor authentication, least-privilege access policies, and continuous verification form the foundation. Tools like BeyondCorp Enterprise and Zscaler provide enterprise-grade implementations.\n\nMicrosegmentation is the next layer, dividing the network into small segments with independent security policies. This limits lateral movement in case of a breach and provides granular control over traffic flows.\n\nMonitoring and analytics are crucial. Zero Trust generates vast amounts of telemetry data. SIEM systems and UEBA tools help identify anomalies and potential threats in real-time.',
      author: 'Chris Taylor',
      source: 'SANS Institute',
      publishedAt: '6h ago',
      readTime: 10,
      category: ExploreCategory.cybersecurity,
      tags: ['zero-trust', 'security', 'enterprise', 'trending'],
    ),
    const ExploreArticle(
      id: 'sec-2',
      title: 'Supply Chain Security in Open Source',
      summary: 'Protecting your software supply chain from increasingly sophisticated attacks.',
      content: 'Software supply chain attacks have become one of the most dangerous threats facing modern development. The SolarWinds breach, Log4Shell, and xz utils backdoor have highlighted the vulnerability of open source dependencies.\n\nSoftware Bill of Materials (SBOM) is becoming a regulatory requirement and a security best practice. Tools like Syft and CycloneDX generate comprehensive dependency inventories that help track and manage supply chain risks.\n\nDependency scanning in CI/CD pipelines is essential. Snyk, Dependabot, and Trivy can identify known vulnerabilities in dependencies before they reach production. Automated dependency updates with testing ensure patches are applied promptly.\n\nSigstore and in-toto provide cryptographic verification of software provenance. These tools ensure that the code you deploy hasn\'t been tampered with between the developer\'s machine and your production environment.\n\nReproducible builds add another layer of security by ensuring that the same source code always produces identical binaries, making it possible to verify build integrity independently.',
      author: 'Nina Patel',
      source: 'SecurityWeek',
      publishedAt: '10h ago',
      readTime: 7,
      category: ExploreCategory.cybersecurity,
      tags: ['supply-chain', 'open-source', 'SBOM', 'popular'],
    ),
    const ExploreArticle(
      id: 'sec-3',
      title: 'AI-Powered Threat Detection',
      summary: 'How machine learning is revolutionizing cybersecurity defense mechanisms.',
      content: 'Artificial intelligence is transforming cybersecurity from reactive to proactive. Modern threat detection systems use machine learning to identify and respond to attacks faster than any human analyst could.\n\nUser and Entity Behavior Analytics (UEBA) establishes baseline behavior patterns and detects anomalies that may indicate compromised accounts or insider threats. These systems continuously learn and adapt to evolving patterns.\n\nNetwork detection and response (NDR) platforms use deep learning to analyze network traffic patterns, identifying command-and-control communications, data exfiltration, and lateral movement without relying on signatures.\n\nThe challenge is balancing sensitivity with specificity. Too many false positives create alert fatigue, while too few alerts mean missed threats. Modern systems use ensemble methods and context-aware scoring to optimize this balance.\n\nAdversarial ML is the emerging frontier where attackers try to fool security AI systems. Understanding these attack vectors is crucial for building robust defenses.',
      author: 'Ahmed Hassan',
      source: 'Dark Reading',
      publishedAt: '2d ago',
      readTime: 8,
      category: ExploreCategory.cybersecurity,
      tags: ['AI-security', 'threat-detection', 'ML', 'trending'],
    ),
    const ExploreArticle(
      id: 'devops-1',
      title: 'Platform Engineering: Building Internal Developer Platforms',
      summary: 'Why platform engineering is the future of DevOps and developer experience.',
      content: 'Platform engineering has emerged as the evolution of DevOps, focusing on building internal developer platforms that abstract infrastructure complexity. This approach is transforming how engineering teams ship software.\n\nThe goal is simple: provide developers with self-service capabilities that follow best practices by default. Instead of requiring developers to understand Kubernetes manifests, Terraform configs, and CI/CD pipelines, a well-designed platform provides simple interfaces for common tasks.\n\nTools like Backstage, Humanitec, and Kratix provide the foundation for building these platforms. Backstage serves as a developer portal, Humanitec handles dynamic infrastructure configuration, and Kratix enables platform composition.\n\nMeasuring platform success requires tracking developer experience metrics alongside traditional operational metrics. DORA metrics, developer satisfaction surveys, and time-to-first-deployment are key indicators.\n\nThe most successful platforms evolve iteratively based on developer feedback. Starting with the most painful workflows and expanding based on team needs ensures adoption and value delivery.',
      author: 'Kelsey Hightower',
      source: 'InfoQ',
      publishedAt: '5h ago',
      readTime: 9,
      category: ExploreCategory.devops,
      tags: ['platform-engineering', 'developer-experience', 'DevOps', 'popular'],
    ),
    const ExploreArticle(
      id: 'devops-2',
      title: 'GitOps with ArgoCD: Advanced Patterns',
      summary: 'Moving beyond basic GitOps to production-grade deployment patterns.',
      content: 'GitOps has become the standard for Kubernetes deployments, and ArgoCD is the leading tool for implementing it. This article covers advanced patterns that go beyond basic setup.\n\nApplicationSets enable managing hundreds of applications from a single definition. Using generators for clusters, environments, and git directories, you can create dynamic configurations that scale with your organization.\n\nProgressive delivery with Argo Rollouts provides safe deployment strategies. Canary deployments, blue-green releases, and A/B testing can be fully automated based on metrics from Prometheus, Datadog, or New Relic.\n\nMulti-tenancy in ArgoCD requires careful consideration of RBAC, project isolation, and resource tracking. The ApplicationProject resource provides fine-grained control over what teams can deploy and where.\n\nSecret management remains a challenge in GitOps. Sealed Secrets, External Secrets Operator, and Vault integration each have trade-offs that must be evaluated based on your security requirements and operational complexity tolerance.',
      author: 'Jason Hall',
      source: 'Argo Project',
      publishedAt: '8h ago',
      readTime: 8,
      category: ExploreCategory.devops,
      tags: ['GitOps', 'ArgoCD', 'Kubernetes', 'CI/CD'],
    ),
    const ExploreArticle(
      id: 'devops-3',
      title: 'Observability Engineering Practices',
      summary: 'Building observable systems that enable rapid incident response.',
      content: 'Observability has evolved beyond traditional monitoring to encompass logs, metrics, and traces as a unified discipline. Modern observability engineering focuses on enabling teams to understand and debug complex distributed systems.\n\nOpenTelemetry has become the standard for instrumenting applications. Its vendor-neutral SDK and collector architecture make it easy to generate telemetry data without lock-in to any specific observability platform.\n\nService meshes like Istio and Linkerd provide automatic instrumentation for service-to-service communication. Combined with application-level traces, they give complete visibility into request flows across microservices.\n\nSLO-based monitoring shifts the focus from infrastructure metrics to user experience. By defining Service Level Objectives and tracking error budgets, teams can make data-driven decisions about reliability investments.\n\nAI-powered observability tools can automatically detect anomalies, correlate events across services, and suggest root causes. These capabilities are becoming essential for managing increasingly complex systems.',
      author: 'Charity Majors',
      source: 'Observability Engineering',
      publishedAt: '1d ago',
      readTime: 7,
      category: ExploreCategory.devops,
      tags: ['observability', 'OpenTelemetry', 'monitoring', 'SLO'],
    ),
    const ExploreArticle(
      id: 'start-1',
      title: 'YC W25 Batch: AI-First Startups Dominate',
      summary: 'Analysis of the latest Y Combinator batch reveals continued AI dominance.',
      content: 'The Y Combinator W25 batch has been announced, and the trend toward AI-first startups continues to accelerate. Of the 240 companies in the batch, over 70% are building AI-powered products.\n\nThe most interesting shift is the move from infrastructure AI companies to application-layer AI. While previous batches featured many model providers and MLOps tools, this batch focuses on vertical AI applications in healthcare, legal, education, and finance.\n\nDeveloper tools remain a strong category, with several companies building AI-powered coding assistants, testing frameworks, and deployment platforms. The competition in this space is fierce, but the market continues to grow.\n\nClimate tech and biotech also have strong representation, often combined with AI. Using machine learning for drug discovery, materials science, and climate modeling represents a convergence of deep tech and AI capabilities.\n\nThe valuation landscape has shifted as well, with AI companies commanding higher initial valuations due to the perceived market opportunity. This creates both opportunities and challenges for founders navigating the fundraising process.',
      author: 'Jessica Liu',
      source: 'TechCrunch',
      publishedAt: '3h ago',
      readTime: 6,
      category: ExploreCategory.startups,
      tags: ['YCombinator', 'startups', 'AI', 'funding', 'trending'],
    ),
    const ExploreArticle(
      id: 'start-2',
      title: 'Building a SaaS: Revenue Metrics That Matter',
      summary: 'Understanding the key financial metrics for SaaS startup success.',
      content: 'For SaaS founders, understanding revenue metrics is crucial for fundraising, growth planning, and operational decisions. This guide covers the metrics that matter most and how to optimize them.\n\nAnnual Recurring Revenue (ARR) remains the north star metric, but the composition matters as much as the total. Net New ARR, expansion ARR, and churned ARR tell the full story of business health.\n\nNet Revenue Retention (NRR) is increasingly the most important metric for investors. NRR above 120% indicates strong product-market fit and expansion potential. Below 100% means you\'re leaking revenue faster than you\'re acquiring it.\n\nCustomer Acquisition Cost (CAC) payback period determines how efficiently you can grow. A payback period under 12 months is generally considered healthy for B2B SaaS.\n\nThe Rule of 40 provides a simple health check: your growth rate plus profit margin should exceed 40%. High-growth companies can trade profitability for growth, but the balance becomes critical as companies mature.',
      author: 'Michael Seibel',
      source: 'SaaStr',
      publishedAt: '7h ago',
      readTime: 8,
      category: ExploreCategory.startups,
      tags: ['SaaS', 'metrics', 'fundraising', 'business'],
    ),
    const ExploreArticle(
      id: 'start-3',
      title: 'Open Source Business Models in 2025',
      summary: 'How successful companies monetize open source software sustainably.',
      content: 'The open source business model landscape has matured significantly. Companies are finding sustainable ways to monetize open source while maintaining community goodwill.\n\nThe open-core model remains the most popular approach. Core functionality is open source, while enterprise features like SSO, RBAC, and advanced monitoring are paid. Grafana Labs, GitLab, and Redis have demonstrated this model at scale.\n\nCloud-managed services have become increasingly important. offering a managed cloud version of open source software provides recurring revenue while handling the operational complexity that many users prefer to avoid.\n\nLicense innovation is accelerating. Companies like HashiCorp, Elastic, and MongoDB have moved away from permissive licenses to more restrictive ones that prevent cloud providers from offering competing services.\n\nDeveloper-led growth strategies combine open source adoption with commercial conversion. By building products that developers love and naturally expand within organizations, companies create efficient go-to-market motions.',
      author: 'Nadia Eghbal',
      source: 'First Round Review',
      publishedAt: '2d ago',
      readTime: 7,
      category: ExploreCategory.startups,
      tags: ['open-source', 'business-model', 'SaaS', 'popular'],
    ),
    const ExploreArticle(
      id: 'res-1',
      title: 'Scaling Laws and AI Model Efficiency',
      summary: 'New research challenges assumptions about compute requirements for AI progress.',
      content: 'A groundbreaking paper from researchers at Stanford and MIT challenges the conventional wisdom about AI scaling laws. The findings suggest that clever training techniques can achieve comparable results with significantly less compute.\n\nThe traditional scaling laws, popularized by OpenAI, suggested that model performance improves predictably with increases in parameters, data, and compute. However, this new research shows that architecture innovations and training techniques can shift these curves dramatically.\n\nMixture of Experts (MoE) architectures are a key example. By activating only a subset of parameters for each input, MoE models can be much larger without proportionally increasing compute requirements. This has led to models with hundreds of billions of parameters running efficiently.\n\nData quality emerges as potentially more important than data quantity. Curated, deduplicated, and carefully filtered training datasets consistently produce better models than larger but noisier datasets.\n\nThese findings have significant implications for the AI industry, potentially enabling smaller teams to compete with well-resourced labs through smart research rather than brute-force compute scaling.',
      author: 'Dr. Yann Chen',
      source: 'arXiv',
      publishedAt: '12h ago',
      readTime: 10,
      category: ExploreCategory.research,
      tags: ['research', 'AI', 'scaling', 'trending'],
    ),
    const ExploreArticle(
      id: 'res-2',
      title: 'Quantum Error Correction Breakthrough',
      summary: 'New error correction codes bring practical quantum computing closer to reality.',
      content: 'Researchers at Google Quantum AI have announced a significant breakthrough in quantum error correction. Their new surface code implementation achieves error rates below the threshold needed for practical quantum computing.\n\nError correction has been the primary obstacle to building useful quantum computers. Quantum bits are extremely fragile, and maintaining coherence long enough to perform meaningful computations requires sophisticated error correction.\n\nThe breakthrough involves a new approach to syndrome extraction that reduces the overhead of error correction by 40%. This means fewer physical qubits are needed for each logical qubit, bringing practical quantum computers closer to reality.\n\nThese advances have implications for quantum algorithms in cryptography, drug discovery, materials science, and optimization. While general-purpose quantum computers are still years away, specialized quantum processors for specific problems may be achievable within the next decade.\n\nThe race between quantum computing development and post-quantum cryptography has also intensified, with NIST\'s new post-quantum standards seeing accelerated adoption.',
      author: 'Dr. Priya Kumar',
      source: 'Nature Physics',
      publishedAt: '1d ago',
      readTime: 12,
      category: ExploreCategory.research,
      tags: ['quantum', 'research', 'breakthrough', 'physics'],
    ),
    const ExploreArticle(
      id: 'res-3',
      title: 'Neurosymbolic AI: Bridging Learning and Reasoning',
      summary: 'Combining neural networks with symbolic reasoning for more robust AI systems.',
      content: 'Neurosymbolic AI represents a promising direction that combines the pattern recognition capabilities of neural networks with the logical reasoning of symbolic AI. This hybrid approach addresses many limitations of pure deep learning.\n\nCurrent neural networks excel at perception tasks but struggle with reasoning, compositionality, and explainability. Symbolic systems provide these capabilities but lack the flexibility and learning ability of neural networks.\n\nSeveral architectures have emerged for combining these approaches. Neural-guided symbolic reasoning uses neural networks to suggest which logical rules to apply, while symbolic-guided neural learning uses logical constraints to shape neural network training.\n\nApplications in scientific discovery are particularly promising. Neurosymbolic systems can learn patterns from experimental data while respecting known physical laws and constraints, leading to more reliable and interpretable models.\n\nThe challenge remains in scaling these approaches to complex real-world problems. Current neurosymbolic systems work well in constrained domains but need further development to handle the messiness of open-world scenarios.',
      author: 'Dr. Joshua Tenenbaum',
      source: 'AI Magazine',
      publishedAt: '3d ago',
      readTime: 9,
      category: ExploreCategory.research,
      tags: ['neurosymbolic', 'research', 'reasoning', 'AI'],
    ),
    const ExploreArticle(
      id: 'gh-1',
      title: 'GitHub Copilot Workspace: AI-Native Development',
      summary: 'GitHub\'s new AI workspace redefines the software development workflow.',
      content: 'GitHub Copilot Workspace represents a paradigm shift in how developers interact with code. This AI-native development environment goes beyond code completion to handle entire development workflows.\n\nThe workspace can take a GitHub issue description and generate a complete implementation plan, including code changes, tests, and documentation. Developers review and refine the AI\'s suggestions rather than writing everything from scratch.\n\nThe integration with GitHub\'s platform is deep. Pull request reviews, issue triage, security scanning, and release management are all augmented by AI capabilities that understand the full context of your project.\n\nEarly adopters report significant productivity improvements, particularly for routine tasks like writing tests, updating documentation, and implementing well-specified features. The tool is less helpful for novel architectural decisions but excels at tactical implementation.\n\nConcerns about code quality and developer skill atrophy are valid but manageable. The tool works best when used by experienced developers who can evaluate and improve AI-generated code.',
      author: 'Nat Friedman',
      source: 'GitHub Blog',
      publishedAt: '4h ago',
      readTime: 6,
      category: ExploreCategory.github,
      tags: ['GitHub', 'Copilot', 'AI-coding', 'trending', 'popular'],
    ),
    const ExploreArticle(
      id: 'gh-2',
      title: 'Open Source Sustainability Crisis',
      summary: 'The growing gap between open source usage and maintainer support.',
      content: 'The open source ecosystem faces a sustainability crisis that threatens the foundation of modern software. Major projects rely on overworked maintainers with inadequate funding, creating systemic risk for the entire technology industry.\n\nThe xz utils backdoor incident highlighted how a single overworked maintainer can become a security liability. The maintainer was under pressure to add contributors who turned out to have malicious intent.\n\nFunding models are evolving. GitHub Sponsors, Open Collective, and corporate sponsorship programs provide income for some maintainers, but the distribution is highly unequal. A few high-profile projects receive most funding while critical infrastructure projects go unsupported.\n\nTidelift, thanks.dev, and similar platforms attempt to create sustainable economic models by connecting open source maintenance with enterprise value. These approaches show promise but haven\'t reached the scale needed to solve the problem.\n\nThe community is exploring new approaches including cooperative ownership models, foundation governance, and government funding for critical digital infrastructure. The outcome will significantly impact the future of software development.',
      author: 'Nadia Asparouhova',
      source: 'OSS Capital',
      publishedAt: '1d ago',
      readTime: 8,
      category: ExploreCategory.github,
      tags: ['open-source', 'sustainability', 'maintainers', 'popular'],
    ),
    const ExploreArticle(
      id: 'gh-3',
      title: 'Monorepo Tools Comparison 2025',
      summary: 'Nx vs Turborepo vs Bazel: choosing the right monorepo tool.',
      content: 'Monorepos have become the preferred architecture for many organizations, but choosing the right tooling is critical. This comparison examines the three leading options and their ideal use cases.\n\nNx excels in the JavaScript/TypeScript ecosystem with excellent plugin support, affected analysis, and task caching. Its integration with Angular, React, and other frameworks makes it the default choice for frontend-heavy monorepos.\n\nTurborepo takes a simpler approach with a focus on speed and ease of adoption. Built by Vercel, it integrates seamlessly with Next.js projects and provides excellent incremental build capabilities with minimal configuration.\n\nBazel is the heavyweight option for massive repositories with diverse language support. Google, Stripe, and other large organizations use Bazel for repositories with millions of lines of code across dozens of languages.\n\nThe choice often depends on team size, language diversity, and existing infrastructure. Smaller teams benefit from Turborepo\'s simplicity, mid-size teams from Nx\'s comprehensive feature set, and large enterprises from Bazel\'s scalability.\n\nAll three tools continue to evolve rapidly, with increasing convergence on key features like remote caching, distributed builds, and improved developer experience.',
      author: 'Marc Sedam',
      source: 'Thoughtworks',
      publishedAt: '6h ago',
      readTime: 7,
      category: ExploreCategory.github,
      tags: ['monorepo', 'Nx', 'Turborepo', 'Bazel', 'tools'],
    ),
    const ExploreArticle(
      id: 'evt-1',
      title: 'KubeCon NA 2025: Key Takeaways',
      summary: 'The biggest announcements and trends from the cloud native conference.',
      content: 'KubeCon North America 2025 wrapped up with record attendance and a clear focus on platform engineering, AI infrastructure, and security. Here are the key takeaways that will shape the industry.\n\nPlatform engineering dominated the conversation. Nearly every vendor announced platform-related features, and the Platform Engineering track was the most attended. The message is clear: the future of DevOps is developer platforms.\n\nAI infrastructure was the second major theme. With the explosive growth of AI workloads, Kubernetes is becoming the platform for training and serving ML models. Projects like KServe, Kubeflow, and Ray on Kubernetes are maturing rapidly.\n\nSecurity remained a top concern, with new projects focused on supply chain security, runtime protection, and policy-as-code. The CNCF announced several new security-focused sandbox projects.\n\nThe eBPF ecosystem continued to expand, with networking, security, and observability tools leveraging kernel-level programmability for unprecedented visibility and control.\n\nCommunity and governance discussions highlighted the growing importance of diversity, sustainability, and responsible AI in the cloud native ecosystem.',
      author: 'Liz Rice',
      source: 'CNCF Blog',
      publishedAt: '8h ago',
      readTime: 8,
      category: ExploreCategory.events,
      tags: ['KubeCon', 'Kubernetes', 'conference', 'trending'],
    ),
    const ExploreArticle(
      id: 'evt-2',
      title: 'React Summit 2025 Recap',
      summary: 'Highlights from the world\'s largest React conference.',
      content: 'React Summit 2025 brought together the React community for two days of talks, workshops, and networking. The conference revealed the direction of the React ecosystem and emerging best practices.\n\nReact Server Components have reached maturity, with most major frameworks adopting them as the default rendering strategy. The performance improvements and developer experience enhancements have convinced even skeptics of their value.\n\nThe new React compiler, previously codenamed React Forget, was a major topic. Automatic memoization eliminates the need for useMemo, useCallback, and React.memo in most cases, simplifying React code significantly.\n\nState management continued to evolve, with signals-based approaches gaining traction. Preact Signals, Angular signals, and similar patterns are influencing how the broader ecosystem thinks about reactivity.\n\nEdge rendering and streaming SSR were highlighted as key performance optimization strategies. Frameworks are increasingly designed to deploy to edge networks for optimal global performance.\n\nThe conference also featured important discussions about React\'s role in the AI era, with several talks exploring how React applications can integrate AI capabilities effectively.',
      author: 'Dan Abramov',
      source: 'React Summit',
      publishedAt: '2d ago',
      readTime: 7,
      category: ExploreCategory.events,
      tags: ['React', 'conference', 'frontend', 'RSC'],
    ),
    const ExploreArticle(
      id: 'evt-3',
      title: 'AWS re:Invent 2025 Predictions',
      summary: 'What to expect from Amazon\'s biggest cloud computing event.',
      content: 'AWS re:Invent 2025 is just around the corner, and the anticipation is building. Based on industry trends and AWS\'s recent trajectory, here are our predictions for the biggest announcements.\n\nAI and ML services will dominate the keynote. AWS is expected to announce new Bedrock features, enhanced SageMaker capabilities, and possibly a new generation of custom AI chips to compete with Google TPUs and NVIDIA GPUs.\n\nSustainability will be a major theme. AWS has committed to net-zero carbon by 2040, and new tools for measuring and optimizing the carbon footprint of cloud workloads are likely.\n\nEdge computing and IoT will see significant expansion. AWS Outposts, Wavelength, and Local Zones continue to grow, and new integrations with 5G networks are expected.\n\nSecurity enhancements will address growing concerns about cloud security posture management, data protection, and compliance automation.\n\nThe developer experience will receive attention with improvements to AWS CDK, SAM, and possibly new tools for infrastructure management that simplify the increasingly complex AWS ecosystem.',
      author: 'Adrian Cockcroft',
      source: 'AWS News',
      publishedAt: '1d ago',
      readTime: 6,
      category: ExploreCategory.events,
      tags: ['AWS', 're:Invent', 'cloud', 'conference'],
    ),
  ];

  final Set<String> _bookmarkedIds = {};
  final Map<String, double> _readingProgress = {};

  List<ExploreArticle> getAllArticles() => List.unmodifiable(_articles);

  List<ExploreArticle> getArticlesByCategory(ExploreCategory category) =>
      _articles.where((a) => a.category == category).toList();

  List<ExploreArticle> searchArticles(String query) {
    final q = query.toLowerCase();
    return _articles.where((a) =>
        a.title.toLowerCase().contains(q) ||
        a.summary.toLowerCase().contains(q) ||
        a.tags.any((t) => t.toLowerCase().contains(q))).toList();
  }

  List<ExploreArticle> getBookmarkedArticles() =>
      _articles.where((a) => _bookmarkedIds.contains(a.id)).toList();

  void toggleBookmark(String articleId) {
    if (_bookmarkedIds.contains(articleId)) {
      _bookmarkedIds.remove(articleId);
    } else {
      _bookmarkedIds.add(articleId);
    }
  }

  bool isBookmarked(String articleId) => _bookmarkedIds.contains(articleId);

  void updateReadingProgress(String articleId, double progress) {
    _readingProgress[articleId] = progress;
  }

  double getReadingProgress(String articleId) =>
      _readingProgress[articleId] ?? 0.0;

  List<ExploreArticle> getPopularArticles() =>
      _articles.where((a) => a.tags.contains('popular')).toList();

  List<ExploreArticle> getTrendingArticles() =>
      _articles.where((a) => a.tags.contains('trending')).toList();
}
