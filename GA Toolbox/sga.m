clear;
%Define parameters and vairables

%Parameters

NIND = 500;             %Number of indviduals per sub populations
MAXGEN = 150;           %Maximun Number of generations
GGAP = 0.8;             %Generation gap, how may new individuals arae created (default 1)
NVAR = 7;               %Number of decision variables
PRECI = 20;             %Precision of binary representation (default 20)
RecOpt = 0.7;           %Probability of recombination/crossover (default 0.7)
Lind = NVAR * PRECI;    %Length of the individual chromosomes
Pm = 0.7/Lind;          %Mutation probability (default 0.7)
SEL_OP = 'sus';         %Selection operator
XOV_OP = 'xovsh';       %Crossover operator
MUT_OP = 'mut';         %Crossover operator
OBJ_F = 'G9';           %Object function


%Variables

FieldD = rep([PRECI, -10, 10, 1, 0, 1, 1]', [1, NVAR]);     %variable range and attribute settings
%Chrom = crtbp(NIND, Lind);                                 %initial Chrom
%gen =1;                                                    %n-th generation
%run = 1;                                                   %loop number
%x = ;                                                      %convert binary number into real number
%ObjV = G9(x);                                              %obtain function value
Best = zeros(MAXGEN, 1);                                    %recording the best function value (to store all the best values in all generations)
All_Best = zeros(MAXGEN, 20);                               %recording the best function value (to store all the best values in all generations in all runs)

%Main loop

%20 runs
for run = 1:20
    %Initial Chrom
    Chrom = crtbp(NIND, Lind);
    
    %MAXGEN generations in one run
    for gen = 1:MAXGEN

        % Convert binary number into real number
        x = bs2rv(Chrom, FieldD);

        % Obtain function values for the current generation
        for i = 1:NIND
            ObjV(i,:) = G9(x(i,:));
        end

        %Output FitnV based on objective function value through ranking function 
        X
        FitnV = ranking(ObjV);

        
        %Using select function, selecting parents based on fitness (entering mating pool）
        SelCh = select(SEL_OP, Chrom, FitnV, 1.0, 1);

        %Crossover
        SelCh = recombin(XOV_OP, SelCh, RecOpt);

        %Mutation
        SelCh = mutate(MUT_OP, SelCh, [], Pm);

        %Recording parent objective function value (for elitism)
        ObjVCh = ObjV;

        %Calculate objective function value
        Phen = bs2rv(SelCh, FieldD);
        for i = 1:NIND
            ObjV(i,:) = G9(Phen(i,:));
        end
        
        %Recording child objective function value (for elitism)
        ObjVSel = ObjV;

        %recording minimum value in current generation
        Best(gen, :) = min(min(ObjV));

        %Elitism
        [Selch, ObjVCh] = reins(Chrom, SelCh, 1, 1, ObjVCh, ObjVSel);

        %Refresh population,replace parent with children
        Chrom = SelCh;
        
    end

    %recording minimum value in current run
    All_Best(:, run) = Best;

end

%Transpose. After transpose, each column represents a generation, each
%row represents a run.
All_Best = All_Best';

%Record best, sorst, mean and median value

All_best = zeros(1, MAXGEN);
All_worst = zeros(1, MAXGEN);
All_mean = zeros(1, MAXGEN);
All_median = zeros(1, MAXGEN);


for gen = 1:MAXGEN
    All_best(:,gen) = min(All_Best(:,gen));
    All_worst(:,gen) = max(All_Best(:,gen));
    All_mean(:,gen) = mean(All_Best(:,gen));
    All_median(:,gen) = median(All_Best(:,gen));
end

%plot figure
figure;
plot(All_median,'r');
hold on;
plot(All_best, 'g');
plot(All_worst, 'b');
plot(All_mean, 'm');
legend('median value','best value','worst value','mean value')
xlabel('generation');
ylabel('f(x)');