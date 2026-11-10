import * as React from "react";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

const buttonVariants = cva(
  "inline-flex items-center justify-center gap-2 rounded-xl text-sm font-bold transition active:scale-[0.98] disabled:opacity-45 disabled:pointer-events-none",
  {
    variants: {
      variant: {
        default: "bg-soft text-ink hover:brightness-95",
        primary: "bg-lima text-brand-900 hover:brightness-95",
        dark: "bg-brand-800 text-white hover:brightness-110",
        danger: "bg-danger text-white",
        ghost: "bg-transparent border border-line",
        claude: "bg-gradient-to-br from-brand-800 to-brand-700 text-white",
      },
      size: {
        default: "px-4 py-2.5",
        sm: "px-3 py-1.5 text-xs rounded-lg",
        lg: "px-5 py-3.5 text-base rounded-2xl",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: { variant: "default", size: "default" },
  },
);

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {}

export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, ...props }, ref) => (
    <button
      ref={ref}
      className={cn(buttonVariants({ variant, size }), className)}
      {...props}
    />
  ),
);
Button.displayName = "Button";
