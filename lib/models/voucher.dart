class Voucher {
  final String code;
  final String title;
  final String subtitle;
  final int minSpend;
  final int discountValue;
  final VoucherType type;

  const Voucher({
    required this.code,
    required this.title,
    required this.subtitle,
    this.minSpend = 0,
    this.discountValue = 0,
    this.type = VoucherType.percent,
  });

  int discountFor(int subtotal, int shippingCost) {
    if (subtotal < minSpend) return 0;
    switch (type) {
      case VoucherType.percent:
        return (subtotal * discountValue / 100).round();
      case VoucherType.fixed:
        return discountValue;
      case VoucherType.shipping:
        return shippingCost;
    }
  }
}

enum VoucherType { percent, fixed, shipping }
