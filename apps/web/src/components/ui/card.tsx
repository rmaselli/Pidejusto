import { cn } from "@/lib/utils";

export function Card({
  className,
  ...props
}: React.HTMLAttributes<HTMLDivElement>) {
  return (
    <div
      className={cn(
        "rounded-[18px] border border-line bg-card p-5 shadow-[0_1px_2px_rgba(16,49,43,.06),0_10px_28px_rgba(16,49,43,.07)]",
        className,
      )}
      {...props}
    />
  );
}

export function Badge({
  className,
  tone = "default",
  ...props
}: React.HTMLAttributes<HTMLSpanElement> & {
  tone?: "default" | "ok" | "warn" | "bad" | "lima" | "dark";
}) {
  const tones = {
    default: "bg-soft text-ink",
    ok: "bg-[#E3F1DA] text-[#0a5a2a]",
    warn: "bg-[#F6EBCB] text-[#7a5a08]",
    bad: "bg-[#F8E6E1] text-danger",
    lima: "bg-lima text-brand-900",
    dark: "bg-brand-900 text-white",
  };
  return (
    <span
      className={cn(
        "inline-flex items-center rounded-full px-2.5 py-0.5 text-[11.5px] font-semibold",
        tones[tone],
        className,
      )}
      {...props}
    />
  );
}
