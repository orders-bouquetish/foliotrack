import React from 'react';
import {
  View, Text, TouchableOpacity, StyleSheet,
  ActivityIndicator, TextInput,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useApp } from '../context/AppContext';

// ── StatCard ──────────────────────────────────────────
export const StatCard = ({ label, value, change, changeColor, accent, style }) => {
  const { theme } = useApp();
  const T = theme.colors;
  return (
    <View style={[styles.statCard, { backgroundColor: T.bg1, borderColor: T.bd1 }, style]}>
      {accent && (
        <View style={[styles.statAccent, { backgroundColor: accent }]} />
      )}
      <Text style={[styles.statLabel, { color: T.tx2 }]}>{label}</Text>
      <Text style={[styles.statValue, { color: T.tx0 }]}>{value}</Text>
      {change !== undefined && (
        <Text style={[styles.statChange, { color: changeColor || T.tx2 }]}>{change}</Text>
      )}
    </View>
  );
};

// ── SectionCard ──────────────────────────────────────
export const SectionCard = ({ title, subtitle, children, rightComponent, style }) => {
  const { theme } = useApp();
  const T = theme.colors;
  return (
    <View style={[styles.sectionCard, { backgroundColor: T.bg1, borderColor: T.bd1 }, style]}>
      <View style={[styles.sectionHeader, { borderBottomColor: T.bd1 }]}>
        <View style={{ flex: 1 }}>
          <Text style={[styles.sectionTitle, { color: T.tx0 }]}>{title}</Text>
          {subtitle && <Text style={[styles.sectionSubtitle, { color: T.tx2 }]}>{subtitle}</Text>}
        </View>
        {rightComponent}
      </View>
      <View style={styles.sectionBody}>{children}</View>
    </View>
  );
};

// ── Badge ──────────────────────────────────────────
export const Badge = ({ label, bg, color }) => (
  <View style={[styles.badge, { backgroundColor: bg }]}>
    <Text style={[styles.badgeText, { color }]}>{label}</Text>
  </View>
);

// ── Button ──────────────────────────────────────────
export const Button = ({ label, onPress, variant = 'primary', icon, small, disabled, style }) => {
  const { theme } = useApp();
  const T = theme.colors;

  const variantStyles = {
    primary: { bg: T.teal, color: '#fff', border: 'transparent' },
    secondary: { bg: T.bg2, color: T.tx1, border: T.bd2 },
    danger: { bg: 'transparent', color: T.red, border: 'rgba(231,76,60,0.25)' },
    ghost: { bg: 'transparent', color: T.teal, border: 'transparent' },
  };
  const v = variantStyles[variant] || variantStyles.primary;

  return (
    <TouchableOpacity
      onPress={onPress}
      disabled={disabled}
      style={[
        styles.btn,
        small && styles.btnSm,
        { backgroundColor: v.bg, borderColor: v.border, borderWidth: variant !== 'primary' && variant !== 'ghost' ? 1 : 0 },
        disabled && { opacity: 0.5 },
        style,
      ]}
      activeOpacity={0.75}
    >
      {icon && <Ionicons name={icon} size={small ? 14 : 16} color={v.color} />}
      <Text style={[styles.btnText, small && styles.btnTextSm, { color: v.color }]}>{label}</Text>
    </TouchableOpacity>
  );
};

// ── EmptyState ──────────────────────────────────────
export const EmptyState = ({ icon, title, subtitle, action, actionLabel }) => {
  const { theme } = useApp();
  const T = theme.colors;
  return (
    <View style={styles.emptyState}>
      <Ionicons name={icon || 'file-tray-outline'} size={40} color={T.tx2} />
      <Text style={[styles.emptyTitle, { color: T.tx1 }]}>{title || 'Nothing here yet'}</Text>
      {subtitle && <Text style={[styles.emptySubtitle, { color: T.tx2 }]}>{subtitle}</Text>}
      {action && actionLabel && (
        <Button label={actionLabel} onPress={action} style={{ marginTop: 12 }} />
      )}
    </View>
  );
};

// ── LoadingSpinner ──────────────────────────────────
export const LoadingSpinner = () => {
  const { theme } = useApp();
  return (
    <View style={styles.loading}>
      <ActivityIndicator size="large" color={theme.colors.teal} />
    </View>
  );
};

// ── ProfileDot ──────────────────────────────────────
export const ProfileDot = ({ name, color, size = 28 }) => (
  <View style={{
    width: size, height: size, borderRadius: size / 3,
    backgroundColor: color || '#9aa5b4',
    alignItems: 'center', justifyContent: 'center',
  }}>
    <Text style={{ color: '#fff', fontSize: size * 0.32, fontWeight: '700' }}>
      {name?.substring(0, 2).toUpperCase() || '?'}
    </Text>
  </View>
);

// ── ProgressBar ──────────────────────────────────────
export const ProgressBar = ({ value, max, color, height = 6, style }) => {
  const { theme } = useApp();
  const pct = Math.min(1, Math.max(0, (value || 0) / (max || 1)));
  return (
    <View style={[{ height, borderRadius: height / 2, backgroundColor: theme.colors.bg3, overflow: 'hidden' }, style]}>
      <View style={{ width: `${pct * 100}%`, height: '100%', backgroundColor: color || theme.colors.teal, borderRadius: height / 2 }} />
    </View>
  );
};

// ── Divider ──────────────────────────────────────────
export const Divider = ({ style }) => {
  const { theme } = useApp();
  return <View style={[{ height: 1, backgroundColor: theme.colors.bd1 }, style]} />;
};

// ── SearchBar ──────────────────────────────────────
export const SearchBar = ({ value, onChangeText, placeholder, style }) => {
  const { theme } = useApp();
  const T = theme.colors;
  return (
    <View style={[styles.searchBar, { backgroundColor: T.bg2, borderColor: T.bd1 }, style]}>
      <Ionicons name="search" size={16} color={T.tx2} />
      <TextInput
        value={value}
        onChangeText={onChangeText}
        placeholder={placeholder || 'Search…'}
        placeholderTextColor={T.tx2}
        style={[styles.searchInput, { color: T.tx0 }]}
        returnKeyType="search"
      />
      {value?.length > 0 && (
        <TouchableOpacity onPress={() => onChangeText('')}>
          <Ionicons name="close-circle" size={16} color={T.tx2} />
        </TouchableOpacity>
      )}
    </View>
  );
};

// ── Row ──────────────────────────────────────────────
export const Row = ({ left, right, style }) => (
  <View style={[{ flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center' }, style]}>
    {left}
    {right}
  </View>
);

// ── Pill ──────────────────────────────────────────────
export const Pill = ({ label, color, bg, style }) => (
  <View style={[styles.pill, { backgroundColor: bg || 'rgba(13,148,136,0.1)' }, style]}>
    <Text style={[styles.pillText, { color: color || '#0d9488' }]}>{label}</Text>
  </View>
);

const styles = StyleSheet.create({
  statCard: {
    borderRadius: 10, borderWidth: 1,
    padding: 14, flex: 1, overflow: 'hidden',
  },
  statAccent: {
    position: 'absolute', left: 0, top: 0, bottom: 0, width: 3,
  },
  statLabel: {
    fontSize: 9.5, fontWeight: '700', textTransform: 'uppercase', letterSpacing: 0.8,
  },
  statValue: {
    fontSize: 20, fontWeight: '700', marginTop: 7, letterSpacing: -0.5,
    fontVariant: ['tabular-nums'],
  },
  statChange: {
    fontSize: 11, marginTop: 4, fontVariant: ['tabular-nums'],
  },
  sectionCard: {
    borderRadius: 10, borderWidth: 1,
    marginBottom: 12, overflow: 'hidden',
  },
  sectionHeader: {
    padding: 12, paddingHorizontal: 16,
    flexDirection: 'row', alignItems: 'center',
    borderBottomWidth: 1,
  },
  sectionTitle: { fontSize: 12.5, fontWeight: '600' },
  sectionSubtitle: { fontSize: 10, marginTop: 1 },
  sectionBody: {},
  badge: {
    paddingHorizontal: 7, paddingVertical: 2, borderRadius: 4,
  },
  badgeText: { fontSize: 9.5, fontWeight: '600' },
  btn: {
    flexDirection: 'row', alignItems: 'center', gap: 5,
    paddingVertical: 8, paddingHorizontal: 14,
    borderRadius: 6,
  },
  btnSm: { paddingVertical: 5, paddingHorizontal: 10 },
  btnText: { fontSize: 12.5, fontWeight: '500' },
  btnTextSm: { fontSize: 11.5 },
  emptyState: {
    alignItems: 'center', padding: 32,
  },
  emptyTitle: { fontSize: 14, fontWeight: '600', marginTop: 12 },
  emptySubtitle: { fontSize: 12, marginTop: 6, textAlign: 'center' },
  loading: {
    flex: 1, alignItems: 'center', justifyContent: 'center', padding: 32,
  },
  searchBar: {
    flexDirection: 'row', alignItems: 'center', gap: 8,
    paddingHorizontal: 12, paddingVertical: 8,
    borderRadius: 8, borderWidth: 1,
  },
  searchInput: { flex: 1, fontSize: 13, padding: 0 },
  pill: {
    paddingHorizontal: 8, paddingVertical: 3, borderRadius: 20,
  },
  pillText: { fontSize: 10.5, fontWeight: '600' },
});
