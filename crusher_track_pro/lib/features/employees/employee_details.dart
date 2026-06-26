import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  MODEL
// ─────────────────────────────────────────────
class Employee {
  final String id;
  final String name;
  final String position;
  final String status; // 'Active' | 'On Leave' | 'Inactive'
  final String phone;
  final String email;
  final String address;
  final String hireDate;
  final String assignedProject;
  final String assignedMachine;
  final double hoursWorked;
  final double salary;
  final double overtime;
  final double attendance; // percentage
  final String avatarUrl;

  const Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.status,
    required this.phone,
    required this.email,
    required this.address,
    required this.hireDate,
    required this.assignedProject,
    required this.assignedMachine,
    required this.hoursWorked,
    required this.salary,
    required this.overtime,
    required this.attendance,
    required this.avatarUrl,
  });
}

// ─────────────────────────────────────────────
//  DUMMY DATA
// ─────────────────────────────────────────────
final Employee dummyEmployee = Employee(
  id: 'EMP-0042',
  name: 'Karim Bensalem',
  position: 'Senior Crusher Operator',
  status: 'Active',
  phone: '+213 555 123 456',
  email: 'karim.bensalem@crusherpro.dz',
  address: '12 Rue Didouche Mourad, Sétif, Algeria',
  hireDate: 'March 14, 2019',
  assignedProject: 'Highway M5 Expansion',
  assignedMachine: 'Crusher Unit #3 – Metso LT106',
  hoursWorked: 184,
  salary: 85000,
  overtime: 12.5,
  attendance: 96.4,
  avatarUrl: '',
);

// ─────────────────────────────────────────────
//  THEME TOKENS
// ─────────────────────────────────────────────
class _AppColors {
  static const background = Color(0xFFF8FAFC);
  static const card = Colors.white;
  static const primary = Color(0xFF2563EB);
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF374151);
  static const border = Color(0xFFE5E7EB);
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFEF4444);
  static const onLeave = Color(0xFFF59E0B);

  // Dark
  static const darkBackground = Color(0xFF020817);
  static const darkCard = Color(0xFF0F172A);
  static const darkText = Colors.white;
  static const darkBorder = Color(0xFF1E293B);
  static const darkSecondaryText = Color(0xFF94A3B8);
}

// ─────────────────────────────────────────────
//  MAIN PAGE
// ─────────────────────────────────────────────
class EmployeeDetailsPage extends StatefulWidget {
  final Employee employee;

  const EmployeeDetailsPage({super.key, required this.employee});

  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? _AppColors.darkBackground : _AppColors.background;
    final e = widget.employee;

    return Scaffold(
      backgroundColor: bg,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: CustomScrollView(
          slivers: [
            _HeroHeader(employee: e, isDark: isDark),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 24),
                  _StatusBadgeRow(employee: e, isDark: isDark),
                  const SizedBox(height: 24),
                  _StatsRow(employee: e, isDark: isDark),
                  const SizedBox(height: 24),
                  _SectionCard(
                    isDark: isDark,
                    title: 'Contact Information',
                    icon: Icons.contact_page_outlined,
                    child: _ContactInfoList(employee: e, isDark: isDark),
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    isDark: isDark,
                    title: 'Assignment',
                    icon: Icons.work_outline_rounded,
                    child: _AssignmentInfo(employee: e, isDark: isDark),
                  ),
                  const SizedBox(height: 16),
                  _SectionCard(
                    isDark: isDark,
                    title: 'Attendance',
                    icon: Icons.bar_chart_rounded,
                    child: _AttendanceBar(attendance: e.attendance, isDark: isDark),
                  ),
                  const SizedBox(height: 16),
                  _RecentActivityCard(isDark: isDark),
                  const SizedBox(height: 24),
                  _ActionButtons(employee: e),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  HERO HEADER (SliverAppBar)
// ─────────────────────────────────────────────
class _HeroHeader extends StatelessWidget {
  final Employee employee;
  final bool isDark;

  const _HeroHeader({required this.employee, required this.isDark});

  Color _statusColor(String status) {
    switch (status) {
      case 'Active':
        return _AppColors.success;
      case 'On Leave':
        return _AppColors.warning;
      default:
        return _AppColors.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      stretch: true,
      backgroundColor:
          isDark ? _AppColors.darkCard : _AppColors.primary,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.15),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.15),
            child: IconButton(
              icon: const Icon(Icons.more_vert_rounded,
                  color: Colors.white, size: 20),
              onPressed: () {},
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.blurBackground],
        background: Stack(
          children: [
            // Gradient background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [const Color(0xFF1E3A8A), const Color(0xFF0F172A)]
                      : [const Color(0xFF1D4ED8), const Color(0xFF2563EB)],
                ),
              ),
            ),
            // Decorative circles
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            // Content
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),
                  // Avatar
                  Stack(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.5), width: 3),
                        ),
                        child: ClipOval(
                          child: employee.avatarUrl.isNotEmpty
                              ? Image.network(employee.avatarUrl,
                                  fit: BoxFit.cover)
                              : Center(
                                  child: Text(
                                    employee.name
                                        .split(' ')
                                        .take(2)
                                        .map((s) => s[0])
                                        .join(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _statusColor(employee.status),
                            border:
                                Border.all(color: Colors.white, width: 2.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    employee.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    employee.position,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // ID chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.25), width: 1),
                    ),
                    child: Text(
                      employee.id,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  STATUS BADGE ROW
// ─────────────────────────────────────────────
class _StatusBadgeRow extends StatelessWidget {
  final Employee employee;
  final bool isDark;

  const _StatusBadgeRow({required this.employee, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatusChip(
          label: employee.status,
          color: employee.status == 'Active'
              ? _AppColors.success
              : employee.status == 'On Leave'
                  ? _AppColors.warning
                  : _AppColors.danger,
        ),
        const SizedBox(width: 10),
        _StatusChip(
          label: 'Hired ${employee.hireDate.split(',').last.trim()}',
          color: _AppColors.primary,
          icon: Icons.calendar_today_rounded,
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const _StatusChip({required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 5),
          ] else ...[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  STATS ROW
// ─────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final Employee employee;
  final bool isDark;

  const _StatsRow({required this.employee, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Hours Worked',
            value: '${employee.hoursWorked.toInt()}h',
            icon: Icons.access_time_rounded,
            color: _AppColors.primary,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'Salary',
            value: '${(employee.salary / 1000).toStringAsFixed(0)}K DZD',
            icon: Icons.account_balance_wallet_outlined,
            color: _AppColors.success,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'Overtime',
            value: '${employee.overtime}h',
            icon: Icons.trending_up_rounded,
            color: _AppColors.warning,
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isDark;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? _AppColors.darkCard : _AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? _AppColors.darkBorder : _AppColors.border,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: isDark ? _AppColors.darkText : _AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isDark
                  ? _AppColors.darkSecondaryText
                  : _AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  SECTION CARD WRAPPER
// ─────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final bool isDark;
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.isDark,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? _AppColors.darkCard : _AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? _AppColors.darkBorder : _AppColors.border,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: _AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: isDark
                        ? _AppColors.darkText
                        : _AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(
              color: isDark ? _AppColors.darkBorder : _AppColors.border,
              height: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CONTACT INFO LIST
// ─────────────────────────────────────────────
class _ContactInfoList extends StatelessWidget {
  final Employee employee;
  final bool isDark;

  const _ContactInfoList({required this.employee, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final items = [
      _InfoItem(Icons.phone_outlined, 'Phone', employee.phone),
      _InfoItem(Icons.email_outlined, 'Email', employee.email),
      _InfoItem(Icons.location_on_outlined, 'Address', employee.address),
      _InfoItem(Icons.calendar_month_outlined, 'Hire Date', employee.hireDate),
    ];

    return Column(
      children: items
          .asMap()
          .entries
          .map((e) => _InfoRow(
                item: e.value,
                isDark: isDark,
                isLast: e.key == items.length - 1,
              ))
          .toList(),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  const _InfoItem(this.icon, this.label, this.value);
}

class _InfoRow extends StatelessWidget {
  final _InfoItem item;
  final bool isDark;
  final bool isLast;

  const _InfoRow(
      {required this.item, required this.isDark, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _AppColors.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, size: 17, color: _AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isDark
                          ? _AppColors.darkSecondaryText
                          : _AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.value,
                    style: TextStyle(
                      color: isDark
                          ? _AppColors.darkText
                          : _AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              color: isDark ? _AppColors.darkBorder : _AppColors.border,
              height: 1,
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  ASSIGNMENT INFO
// ─────────────────────────────────────────────
class _AssignmentInfo extends StatelessWidget {
  final Employee employee;
  final bool isDark;

  const _AssignmentInfo({required this.employee, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AssignmentTile(
          icon: Icons.construction_rounded,
          label: 'Project',
          value: employee.assignedProject,
          color: _AppColors.primary,
          isDark: isDark,
        ),
        const SizedBox(height: 12),
        _AssignmentTile(
          icon: Icons.precision_manufacturing_rounded,
          label: 'Machine',
          value: employee.assignedMachine,
          color: _AppColors.warning,
          isDark: isDark,
        ),
      ],
    );
  }
}

class _AssignmentTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  const _AssignmentTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: isDark
                        ? _AppColors.darkSecondaryText
                        : _AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color:
                        isDark ? _AppColors.darkText : _AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded,
              color: isDark
                  ? _AppColors.darkSecondaryText
                  : _AppColors.textSecondary,
              size: 20),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ATTENDANCE BAR
// ─────────────────────────────────────────────
class _AttendanceBar extends StatefulWidget {
  final double attendance;
  final bool isDark;

  const _AttendanceBar({required this.attendance, required this.isDark});

  @override
  State<_AttendanceBar> createState() => _AttendanceBarState();
}

class _AttendanceBarState extends State<_AttendanceBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color get _barColor {
    if (widget.attendance >= 90) return _AppColors.success;
    if (widget.attendance >= 70) return _AppColors.warning;
    return _AppColors.danger;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Monthly Attendance Rate',
              style: TextStyle(
                color: widget.isDark
                    ? _AppColors.darkSecondaryText
                    : _AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${widget.attendance}%',
              style: TextStyle(
                color: _barColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        AnimatedBuilder(
          animation: _anim,
          builder: (_, __) {
            return Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: widget.isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor:
                      (widget.attendance / 100) * _anim.value,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _barColor.withOpacity(0.7),
                          _barColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: _barColor.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _MiniStat('Days Present', '${(widget.attendance / 100 * 22).toStringAsFixed(0)}/22', _AppColors.success, widget.isDark),
            const SizedBox(width: 16),
            _MiniStat('Days Absent', '${(22 - (widget.attendance / 100 * 22)).toStringAsFixed(0)}', _AppColors.danger, widget.isDark),
          ],
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  const _MiniStat(this.label, this.value, this.color, this.isDark);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: TextStyle(
            color: isDark
                ? _AppColors.darkSecondaryText
                : _AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isDark ? _AppColors.darkText : _AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  RECENT ACTIVITY CARD
// ─────────────────────────────────────────────
class _RecentActivityCard extends StatelessWidget {
  final bool isDark;

  const _RecentActivityCard({required this.isDark});

  static const List<Map<String, dynamic>> _activities = [
    {
      'icon': Icons.check_circle_outline_rounded,
      'color': _AppColors.success,
      'text': 'Completed 8h shift on Crusher Unit #3',
      'time': '2 hours ago',
    },
    {
      'icon': Icons.build_outlined,
      'color': _AppColors.warning,
      'text': 'Reported maintenance request for LT106',
      'time': 'Yesterday, 3:45 PM',
    },
    {
      'icon': Icons.local_gas_station_outlined,
      'color': _AppColors.primary,
      'text': 'Logged fuel refill — 120L',
      'time': 'June 23, 9:10 AM',
    },
    {
      'icon': Icons.assignment_turned_in_outlined,
      'color': _AppColors.success,
      'text': 'Production report submitted for M5 Project',
      'time': 'June 22, 5:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      isDark: isDark,
      title: 'Recent Activity',
      icon: Icons.history_rounded,
      child: Column(
        children: _activities.asMap().entries.map((e) {
          final activity = e.value;
          final isLast = e.key == _activities.length - 1;
          return _ActivityRow(
            icon: activity['icon'] as IconData,
            color: activity['color'] as Color,
            text: activity['text'] as String,
            time: activity['time'] as String,
            isDark: isDark,
            isLast: isLast,
          );
        }).toList(),
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final String time;
  final bool isDark;
  final bool isLast;

  const _ActivityRow({
    required this.icon,
    required this.color,
    required this.text,
    required this.time,
    required this.isDark,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line + icon
          Column(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 17),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: isDark
                        ? _AppColors.darkBorder
                        : _AppColors.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    text,
                    style: TextStyle(
                      color: isDark
                          ? _AppColors.darkText
                          : _AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      color: isDark
                          ? _AppColors.darkSecondaryText
                          : _AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ACTION BUTTONS
// ─────────────────────────────────────────────
class _ActionButtons extends StatelessWidget {
  final Employee employee;

  const _ActionButtons({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Call & Message row
        Row(
          children: [
            Expanded(
              child: _PrimaryButton(
                label: 'Call',
                icon: Icons.phone_rounded,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _OutlineButton(
                label: 'Message',
                icon: Icons.chat_bubble_outline_rounded,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Edit full-width
        _OutlineButton(
          label: 'Edit Employee',
          icon: Icons.edit_outlined,
          onTap: () {},
          fullWidth: true,
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PrimaryButton(
      {required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _AppColors.primary,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 52,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool fullWidth;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 52,
          width: fullWidth ? double.infinity : null,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? _AppColors.darkBorder : _AppColors.border,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isDark
                    ? _AppColors.darkText
                    : _AppColors.textPrimary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isDark
                      ? _AppColors.darkText
                      : _AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ENTRY POINT (for standalone testing)
// ─────────────────────────────────────────────
void main() {
  runApp(
    MaterialApp(
      title: 'Employee Details - CrusherTrack Pro',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: _AppColors.primary,
        brightness: Brightness.light,
        scaffoldBackgroundColor: _AppColors.background,
        fontFamily: 'Inter',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: _AppColors.primary,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: _AppColors.darkBackground,
        fontFamily: 'Inter',
      ),
      home: EmployeeDetailsPage(employee: dummyEmployee),
    ),
  );
}