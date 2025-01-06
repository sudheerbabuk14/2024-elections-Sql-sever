select * from constituencywise_details$ 
select * from constituencywise_results$
select * from partywise_results$
select * from states$
select * from statewise_results$ 
--what is the number of seats available for election in each state

select 
state,count([Parliament Constituency]) 
from
statewise_results$ 
group by state

--Total Seats Won by NDA Allianz

update partywise_results$ set [Party allinaz]='NDA' where party='Jharkhand Mukti Morcha - JMM'

update partywise_results$ set [Party allinaz]=
case
when party='Bharatiya Janata Party - BJP'then'NDA'
when party='Janasena Party - JnP' then'NDA'
when party='Telugu Desam - TDP' then'NDA'
when party='Yuvajana Sramika Rythu Congress Party - YSRCP' then'NDA'
when party='Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT'then'INDIA'
when party='Kerala Congress - KEC'then'INDIA'
when party='Aam Aadmi Party - AAAP'then'INDIA'
when party='All India Trinamool Congress - AITC'then'INDIA'
else 'others'end where party in ('Aam Aadmi Party - AAAP','All India Trinamool Congress - AITC',
'Communist Party of India  (Marxist) - CPI(M)',
'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)','Communist Party of India - CPI','Dravida Munnetra Kazhagam - DMK',
'Indian National Congress - INC',
'Indian Union Muslim League - IUML',
'Jammu & Kashmir National Conference - JKN',
'Telugu Desam - TDP',
'Kerala Congress - KEC',
'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
'Rashtriya Janata Dal - RJD',
'Rashtriya Loktantrik Party - RLTP',
'Revolutionary Socialist Party - RSP',
'Samajwadi Party - SP',
'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
'Viduthalai Chiruthaigal Katchi - VCK',
'Aazad Samaj Party (Kanshi Ram) - ASPKR',
'AJSU Party - AJSUP',
'All India Majlis-E-Ittehadul Muslimeen - AIMIM',
'Apna Dal (Soneylal) - ADAL',
'Asom Gana Parishad - AGP',
'Bharat Adivasi Party - BHRTADVSIP',
'Bharatiya Janata Party - BJP',
'Hindustani Awam Morcha (Secular) - HAMS',
'Independent - IND',
'Janasena Party - JnP',
'Janata Dal  (Secular) - JD(S)',
'Janata Dal  (United) - JD(U)',
'Lok Janshakti Party(Ram Vilas) - LJPRV',
'Nationalist Congress Party - NCP',
'Rashtriya Lok Dal - RLD',
'Shiromani Akali Dal - SAD',
'Shiv Sena - SHS',
'Sikkim Krantikari Morcha - SKM',
'United People’s Party, Liberal - UPPL',
'Voice of the People Party - VOTPP',
'Yuvajana Sramika Rythu Congress Party - YSRCP',
'Zoram People’s Movement - ZPM');

select * from constituencywise_details$ 
select * from constituencywise_results$
select * from partywise_results$
select * from states$
select * from statewise_results$ 

--total seats won by nda allian


select sum(Won) as total_won from partywise_results$
where [party allinaz]='NDA';

--seats won by NDA allianz parties
select * from partywise_results$

select party,won 
from partywise_results$
where [party allinaz] ='NDA';

--total seats won by india allianz

select sum(Won) as total_seats_won 
from partywise_results$ 
where [party allinaz]= 'INDiA';

--seats won by INDIA allianz parties

select Party,Won
from partywise_results$
where[party allinaz]='INDIA';

--which party alliance(NDA,india,or other) won the most seats across all states?
use sqlpro1
	SELECT 
    p.[Party allinaz],
    COUNT(cr.[Constituency ID]) AS Seats_Won
FROM 
    constituencywise_results$ cr
JOIN 
    partywise_results$ p ON cr.[Party ID] = p.[Party ID]
WHERE 
    p.[Party allinaz] IN ('NDA', 'INDIA', 'other')
GROUP BY 
    p.[Party allinaz]
ORDER BY 
    Seats_Won DESC;



--Winning candidate's name, their party name, total votes, and 
--the margin of victory for a specific state and constituency?

use sqlpro1
select const.[Winning Candidate],party.Party,const.[Total Votes],const.Margin,[Constituency Name],
states.State from statewise_results$ states
inner join constituencywise_results$  const on
states.Constituency=const.[Constituency Name]
inner join partywise_results$ party
on party.[Party ID]=const.[Party ID]

--What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

--Which parties won the most seats in State, and how many seats did each party win?


select [EVM Votes],[Postal Votes],results.[Constituency Name] ,details.Candidate
from constituencywise_details$ as details
inner join
constituencywise_results$ as results
on details.[Constituency ID]=results.[Constituency ID]
order by details.Candidate ;

--Which parties won the most seats in s State, and how many seats did each party win
select count(cr.cons from constituencywise_results$ as cr;

SELECT 
    p.Party,
    COUNT(cr.[Constituency ID]) AS Seats_Won
FROM 
    constituencywise_results$ cr
JOIN 
    partywise_results$ p ON cr.[Party ID] = p.[Party ID]
JOIN 
    statewise_results$ sr ON cr.[Parliament Constituency] = sr.[Parliament Constituency]
JOIN states$ s ON sr.[State ID] = s.[State ID]
--where
--s.State='andhra pradesh'
GROUP BY 
    p.Party
ORDER BY 
    Seats_Won DESC;

	
--What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) 
--in each state for the India Elections 2024

select 
s.State as state_name,
   sum(Case when pr.[Party allinaz]='NDA' then 1 else 0 end) as nda_seats_won,
   sum(Case when pr.[Party allinaz]='INDIA' then 1 else 0 end) as india_seats,
   sum(Case when pr.[Party allinaz]='others' then 1 else 0 end) as other_seats
from constituencywise_results$ cr
inner join partywise_results$ pr
on
cr.[Party ID]=pr.[Party ID]
inner join statewise_results$  sr 
on
cr.[Parliament Constituency]=sr.[Parliament Constituency]
inner join states$ s 
on s.[State ID]=sr.[State ID]
where pr.[Party allinaz] in('NDA','INDIA','others')
group by
s.State
order by
s.State;

--Which candidate received the highest number of EVM votes in each constituency (Top 10)

select * from constituencywise_details$
select * from constituencywise_results$

select top 10
cr.[Winning Candidate],cd.[EVM Votes],cr.[Constituency Name]
from constituencywise_results$ cr inner join constituencywise_details$ cd
on cr.[Constituency ID]=cd.[Constituency ID]
order by cd.[EVM Votes]desc;


select * from constituencywise_details$
--query explanation;

	with rankedcandidaties AS(
	 select cd.[Constituency ID],cd.Candidate,cd.Party,cd.[Postal Votes],
 (cd.[EVM Votes]+cd.[Postal Votes]) as total_votes,
ROW_NUMBER() OVER (partition BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
  from constituencywise_details$ as cd
join
constituencywise_results$ cr on cd.[Constituency ID]=cr.[Constituency ID]
join
statewise_results$ sr on cr.[Parliament Constituency]=sr.[Parliament Constituency]
join
states$ s on sr.[State ID]=s.[State ID]
where s.State='Maharashtrs'
)
SELECT 
   cr.Constituency_Name,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    constituencywise_results$ cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
    cr.Constituency_Name
ORDER BY 
    cr.Constituency_Name;
