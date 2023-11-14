import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/features/common/text_widgets.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;
  final Color? textColor;
  final Widget? child;
  const AppButton({
    Key? key,
    this.onPressed,
    this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    this.textColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 345.w,
      height: height ?? 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            //Elevation based on states
            elevation: MaterialStateProperty.resolveWith<double>((states) {
              if (states.contains(MaterialState.pressed)) {
                return 0;
              }
              return 4;
            }),
            //Border
            shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 12.0));
            }),
            backgroundColor: color != null
                ? MaterialStateProperty.resolveWith<Color>((states) => color!)
                : null),
        child: child ??
            NormalText(
              text ?? '',
              textColor: textColor ?? Colors.white,
            ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Function()? onPressed;

  const SmallButton({
    Key? key,
    this.text = '',
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      width: width ?? 140.w,
      height: height ?? 43.h,
      borderRadius: 5.0,
      text: text,
      onPressed: onPressed,
    );
  }
}

class VerySmallButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  final Color? textColor;

  const VerySmallButton({
    Key? key,
    this.text = '',
    this.onPressed,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      width: 70.w,
      height: 43.h,
      borderRadius: 5.0,
      text: text,
      color: color,
      textColor: textColor,
      onPressed: onPressed,
    );
  }
}

class UnderlineTextButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const UnderlineTextButton({
    Key? key,
    this.onTap,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.0),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 6.0, top: 2.0, right: 6.0, bottom: 6.0),
        child: NormalText(
          text,
          fontSize: 13.0,
          decoration: TextDecoration.underline,
          textColor: AppColors.batchTextButtonColor,
        ),
      ),
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final bool showArrow;
  final Function()? onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  const AppOutlinedButton({
    Key? key,
    this.text = '',
    this.showArrow = true,
    this.onTap,
    this.width,
    this.height,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 100.0.w,
      height: height ?? 40.0.h,
      child: OutlinedButton(
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NormalText(
                text,
                fontSize: fontSize,
                textColor: Theme.of(context).primaryColor,
              ),
              if (showArrow) const Icon(Icons.chevron_right),
            ],
          )),
    );
  }
}

class SocialMediaSignInButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final Function()? onTap;
  const SocialMediaSignInButton({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 220.0.w,
          child: Row(
            children: [
              icon,
              const Gap(4.0),
              NormalText(text),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  final void Function()? overrideBackButton;

  const AppBackButton({
    super.key,
    this.overrideBackButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: BackButton(
        onPressed: overrideBackButton,
      ),
    );
  }
}

class AddMediaButton extends StatelessWidget {
  final Function()? onPressed;
  final double? width;
  final Color? color;
  final IconData? iconData;
  final String text;
  const AddMediaButton(
    this.text, {
    super.key,
    this.onPressed,
    this.width,
    this.color,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      width: width ?? 128.0,
      color: color ?? const Color(0xFF0C78F8),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NormalText(
            text,
            textColor: Colors.white,
            fontSize: 14.0,
          ),
          const Gap(2.0),
          Icon(
            iconData ?? Icons.add,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class AppArrowButton extends StatelessWidget {
  final Function()? onPressed;
  final double? width;

  final String text;
  const AppArrowButton(
    this.text, {
    super.key,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: AppButton(
        width: width ?? 128.0.w,
        height: 46.0.h,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NormalText(
              text,
              textColor: Colors.white,
            ),
            const Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget? child;
  final double? borderRadius;
  final double? width;
  final double? height;

  const AppIconButton({
    super.key,
    this.child,
    this.onTap,
    this.borderRadius,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 5.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
