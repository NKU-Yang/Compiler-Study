
;; Function main (main, funcdef_no=0, decl_uid=2247, cgraph_uid=0, symbol_order=0)

main ()
{
  int f;
  int n;
  int i;

  scanf ("%d", &n);
  i = 2;
  f = 1;
  goto <D.2253>;
  <D.2252>:
  f = f * i;
  i = i + 1;
  <D.2253>:
  n.0_1 = n;
  if (i <= n.0_1) goto <D.2252>; else goto <D.2254>;
  <D.2254>:
  printf ("%d\n", f);
  n = {CLOBBER};
  return;
}


