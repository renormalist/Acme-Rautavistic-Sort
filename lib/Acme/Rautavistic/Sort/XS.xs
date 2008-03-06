
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* Annahme: macht in place sortierung */
static int
dropsort (IV *list, int count)
{
        return count;
}

/* alles unter MODULE von xsubpp, oben drüber normaler C code */

MODULE = Acme::Rautavistic::Sort::XS PACKAGE = Acme::Rautavistic::Sort::XS

void
dropsort (...)
         PREINIT:
                IV *list;
                int result_length, i;
         PPCODE:
                list = malloc(sizeof(IV) * items); /* list allokieren IntegerValues */
                for (i=0; i < items; i++) {        /* items ist Anzahl Args, von xsubpp gesetzt */
                    list[i] = SvIV(ST(i));         /* */
                }
                result_length = dropsort(list, items);     /* annahme: derzeit in place, und anzahl der zu nutzenden elemente zurückgeben */
                EXTEND(sp,result_length);       /* sp=stackpointer, mindestens result_length elemente */
                for (i=0; i < result_length; i++) {
                    /* PUSHs(sv_2mortal(newSVIV(list[i])));  */ /* neuer liste von IVs als SV interpretieren, mortal machen, das auf stack als Scalar (daher "PUSHs") */
                    mPUSHi(list[i]); /* kompaktere Variante, die impliit integer zu scalar und mortal macht */
                    /* gibt auch xPUSHs oder mxPUSHi, die EXTEND'en selber, kann ich EXTEND sparen */
                }
                free(list);
                XSRETURN(result_length);

