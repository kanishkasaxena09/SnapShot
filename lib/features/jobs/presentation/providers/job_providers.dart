import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/id_set_notifier.dart';
import '../../data/datasources/job_local_datasource.dart';
import '../../domain/entities/job_entities.dart';

final jobDataSourceProvider = Provider<JobLocalDataSource>((ref) => JobLocalDataSource());

final jobSearchQueryProvider = StateProvider<String>((ref) => '');

final jobFilterProvider = StateProvider<JobFilter>((ref) => const JobFilter());

final jobListProvider = Provider<List<Job>>((ref) {
  final query = ref.watch(jobSearchQueryProvider);
  final filter = ref.watch(jobFilterProvider);
  return ref.read(jobDataSourceProvider).searchJobs(query, filter);
});

final allJobsProvider = Provider<List<Job>>((ref) {
  return ref.read(jobDataSourceProvider).getJobs();
});

final savedJobsProvider = StateNotifierProvider<IdSetNotifier, List<String>>((ref) {
  return IdSetNotifier(['j2']);
});

final jobDetailProvider = Provider.family<Job?, String>((ref, jobId) {
  final jobs = ref.read(allJobsProvider);
  try {
    return jobs.firstWhere((j) => j.id == jobId);
  } catch (_) {
    return null;
  }
});

final applicationsProvider = StateNotifierProvider<ApplicationsNotifier, List<JobApplication>>((ref) {
  return ApplicationsNotifier(ref.read(jobDataSourceProvider));
});

class ApplicationsNotifier extends StateNotifier<List<JobApplication>> {
  ApplicationsNotifier(JobLocalDataSource ds) : super(ds.getApplications());

  void apply(Job job) {
    final app = JobApplication(
      id: 'a${DateTime.now().millisecondsSinceEpoch}',
      job: job,
      status: ApplicationStatus.submitted,
      appliedDate: DateTime.now().toIso8601String().substring(0, 10),
    );
    state = [app, ...state];
  }

  void withdraw(String appId) {
    state = state.map((a) => a.id == appId ? a.copyWith(status: ApplicationStatus.withdrawn) : a).toList();
  }
}

final jobAlertsProvider = StateNotifierProvider<JobAlertsNotifier, List<JobAlert>>((ref) {
  return JobAlertsNotifier(ref.read(jobDataSourceProvider));
});

class JobAlertsNotifier extends StateNotifier<List<JobAlert>> {
  JobAlertsNotifier(JobLocalDataSource ds) : super(ds.getAlerts());

  void toggle(String alertId) {
    state = state.map((a) => a.id == alertId ? a.copyWith(isActive: !a.isActive) : a).toList();
  }

  void add(JobAlert alert) {
    state = [alert, ...state];
  }

  void remove(String alertId) {
    state = state.where((a) => a.id != alertId).toList();
  }
}

final salaryInsightProvider = Provider.family<SalaryInsight, String>((ref, title) {
  return ref.read(jobDataSourceProvider).getSalaryInsight(title);
});

final companyProvider = Provider.family<Company?, String>((ref, companyId) {
  return ref.read(jobDataSourceProvider).getCompanyById(companyId);
});

final companyJobsProvider = Provider.family<List<Job>, String>((ref, companyId) {
  return ref.read(jobDataSourceProvider).getJobsByCompany(companyId);
});
