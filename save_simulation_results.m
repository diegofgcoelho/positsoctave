% This script saves the simulations results of evaluating Neumann, Wilkinson,
% and Berstein polynomials using posits.

% Neumann

clear;

load 'neumann_poly_resultsN100';

file_neumann = fopen('neumann_table.tex', 'w');
fprintf(file_neumann,'%s\n','\begin{table}');
fprintf(file_neumann,'%s\n','\begin{center}');
fprintf(file_neumann,'%s\n',strcat('\caption{Upper bound for relative error in the numerical', 
  ' evaluation of Neumann polynomials for different sizes $N$ and different posit',
  ' sizes ($nbits$, $es$)}'));
fprintf(file_neumann,'%s\n','\label{tab:posit_neumann}');
fprintf(file_neumann,'%s','\begin{tabular}{');

[lin col] = size(meancellerrspol1s);

for ii = 1:col
  fprintf(file_neumann,'c@{\\quad}');
endfor
fprintf(file_neumann,'c@{\\quad}} \\\\ \\toprule \n');

for ii = 1:lin-1
  
  if(ii == 1)
  fprintf(file_neumann, ' Posit / Pol Size &');
    for jj = 1:col-1
      fprintf(file_neumann, ' $ N = %d $ &', psize(jj));
    endfor
    fprintf(file_neumann, ' $ N = %d $ \\\\ \\midrule \n', psize(col));
  endif
  
  fprintf(file_neumann, ' ($%d$, $%d$) & ', nbitsvalues(ii), esvalues(ii));
  
  for jj = 1:col-1  
    merr = meancellerrspol1s{ii,jj};
    
    r = disposit(merr, 'float');
    fprintf(file_neumann, '$%s$ & ', r);
  endfor
  %If it is the last column
  merr = meancellerrspol1s{ii,col};
  r = disposit(merr, 'float');
  fprintf(file_neumann, '$%s$ \\\\ \\midrule \n', r);
endfor
%If it is the last row
fprintf(file_neumann, ' ($%d$, $%d$) & ', nbitsvalues(lin), esvalues(lin));
for jj = 1:col-1
  merr = meancellerrspol1s{lin,jj};
    
  r = disposit(merr, 'float');
  fprintf(file_neumann, '$%s$ & ', r);
endfor
%If it is the last column
merr = meancellerrspol1s{lin,col};
r = disposit(merr, 'float');
fprintf(file_neumann, '$%s$ \\\\ \\bottomrule \n', r);

fprintf(file_neumann,'%s\n','\end{tabular}');
fprintf(file_neumann,'%s\n','\end{center}');
fprintf(file_neumann,'%s\n','\end{table}');

fclose(file_neumann);

% Berstein

clear;

load 'berstein_poly_resultsN100';

file_berstein = fopen('berstein_table.tex', 'w');
fprintf(file_berstein,'%s\n','\begin{table}');
fprintf(file_berstein,'%s\n','\begin{center}');
fprintf(file_berstein,'%s\n',strcat('\caption{Upper bound for relative error in the numerical', 
  ' evaluation of Berstein polynomials for different sizes $N$ and different posit',
  ' sizes ($nbits$, $es$)}'));
fprintf(file_berstein,'%s\n','\label{tab:posit_berstein}');
fprintf(file_berstein,'%s','\begin{tabular}{');

[lin col] = size(meancellerrspolbersteins);

for ii = 1:col
  fprintf(file_berstein,'c@{\\quad}');
endfor
fprintf(file_berstein,'c@{\\quad}} \\\\ \\toprule \n');


for ii = 1:lin-1
  
  if(ii == 1)
  fprintf(file_berstein, ' Posit / Pol Size &');
    for jj = 1:col-1
      fprintf(file_berstein, ' $ N = %d $ &', psize(jj));
    endfor
    fprintf(file_berstein, ' $ N = %d $ \\\\ \\midrule \n', psize(col));
  endif  
  
  fprintf(file_berstein, ' ($%d$, $%d$) & ', nbitsvalues(ii), esvalues(ii));
  
  for jj = 1:col-1
    merr = meancellerrspolbersteins{ii,jj};
    
    r = disposit(merr, 'float');
    fprintf(file_berstein, '$%s$ & ', r);
  endfor
  %If it is the last column
  merr = meancellerrspolbersteins{ii,col};
  r = disposit(merr, 'float');
  fprintf(file_berstein, '$%s$ \\\\ \\midrule \n', r);
endfor
%If it is the last row
fprintf(file_berstein, ' ($%d$, $%d$) & ', nbitsvalues(lin), esvalues(lin));
for jj = 1:col-1
  merr = meancellerrspolbersteins{lin,jj};
    
  r = disposit(merr, 'float');
  fprintf(file_berstein, '$%s$ & ', r);
endfor
%If it is the last column
merr = meancellerrspolbersteins{lin,col};
r = disposit(merr, 'float');
fprintf(file_berstein, '$%s$ \\\\ \\bottomrule \n', r);

fprintf(file_berstein,'%s\n','\end{tabular}');
fprintf(file_berstein,'%s\n','\end{center}');
fprintf(file_berstein,'%s\n','\end{table}');

fclose(file_berstein);

% Wilkinson

clear;

load 'wilkinson_poly_resultsN100';

file_wilkinson = fopen('wilkinson_table.tex', 'w');
fprintf(file_wilkinson,'%s\n','\begin{table}');
fprintf(file_wilkinson,'%s\n','\begin{center}');
fprintf(file_wilkinson,'%s\n',strcat('\caption{Upper bound for relative error in the numerical', 
  ' evaluation of Wilkinson polynomials for different sizes $N$ and different posit',
  ' sizes ($nbits$, $es$)}'));
fprintf(file_wilkinson,'%s\n','\label{tab:posit_wilkinson}');
fprintf(file_wilkinson,'%s','\begin{tabular}{');

[lin col] = size(meancellerrspolwilkinsons);

for ii = 1:col
  fprintf(file_wilkinson,'c@{\\quad}');
endfor
fprintf(file_wilkinson,'c@{\\quad}} \\\\ \\toprule \n');


for ii = 1:lin-1
  
  if(ii == 1)
  fprintf(file_wilkinson, ' Posit / Pol Size &');
    for jj = 1:col-1
      fprintf(file_wilkinson, ' $ N = %d $ &', psize(jj));
    endfor
    fprintf(file_wilkinson, ' $ N = %d $ \\\\ \\midrule \n', psize(col));
  endif
  
  fprintf(file_wilkinson, ' ($%d$, $%d$) & ', nbitsvalues(ii), esvalues(ii));
  
  for jj = 1:col-1
    merr = meancellerrspolwilkinsons{ii,jj};
    
    r = disposit(merr, 'float');
    fprintf(file_wilkinson, '$%s$ & ', r);
  endfor
  %If it is the last column
  merr = meancellerrspolwilkinsons{ii,col};
  r = disposit(merr, 'float');
  fprintf(file_wilkinson, '$%s$ \\\\ \\midrule \n', r);
endfor
%If it is the last row
fprintf(file_wilkinson, ' ($%d$, $%d$) & ', nbitsvalues(lin), esvalues(lin));
for jj = 1:col-1
  merr = meancellerrspolwilkinsons{lin,jj};
    
  r = disposit(merr, 'float');
  fprintf(file_wilkinson, '$%s$ & ', r);
endfor
%If it is the last column
merr = meancellerrspolwilkinsons{lin,col};
r = disposit(merr, 'float');
fprintf(file_wilkinson, '$%s$ \\\\ \\bottomrule \n', r);

fprintf(file_wilkinson,'%s\n','\end{tabular}');
fprintf(file_wilkinson,'%s\n','\end{center}');
fprintf(file_wilkinson,'%s\n','\end{table}');

fclose(file_wilkinson);

