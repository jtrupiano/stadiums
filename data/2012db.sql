--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: jtrupiano
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO jtrupiano;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: distances; Type: TABLE; Schema: public; Owner: jtrupiano; Tablespace: 
--

CREATE TABLE distances (
    from_stadium_id integer NOT NULL,
    to_stadium_id integer NOT NULL,
    distance_in_miles integer NOT NULL,
    distance_in_minutes integer NOT NULL
);


ALTER TABLE public.distances OWNER TO jtrupiano;

--
-- Name: games; Type: TABLE; Schema: public; Owner: jtrupiano; Tablespace: 
--

CREATE TABLE games (
    id integer NOT NULL,
    home_stadium_id integer NOT NULL,
    away_stadium_id integer NOT NULL,
    gametime timestamp without time zone NOT NULL
);


ALTER TABLE public.games OWNER TO jtrupiano;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: jtrupiano
--

CREATE SEQUENCE games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO jtrupiano;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jtrupiano
--

ALTER SEQUENCE games_id_seq OWNED BY games.id;


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jtrupiano
--

SELECT pg_catalog.setval('games_id_seq', 256, true);


--
-- Name: stadiums; Type: TABLE; Schema: public; Owner: jtrupiano; Tablespace: 
--

CREATE TABLE stadiums (
    id integer NOT NULL,
    team character varying(55) NOT NULL,
    stadium character varying(100) NOT NULL,
    address character varying(255) NOT NULL
);


ALTER TABLE public.stadiums OWNER TO jtrupiano;

--
-- Name: stadiums_id_seq; Type: SEQUENCE; Schema: public; Owner: jtrupiano
--

CREATE SEQUENCE stadiums_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stadiums_id_seq OWNER TO jtrupiano;

--
-- Name: stadiums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jtrupiano
--

ALTER SEQUENCE stadiums_id_seq OWNED BY stadiums.id;


--
-- Name: stadiums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jtrupiano
--

SELECT pg_catalog.setval('stadiums_id_seq', 160, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jtrupiano
--

ALTER TABLE games ALTER COLUMN id SET DEFAULT nextval('games_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jtrupiano
--

ALTER TABLE stadiums ALTER COLUMN id SET DEFAULT nextval('stadiums_id_seq'::regclass);


--
-- Data for Name: distances; Type: TABLE DATA; Schema: public; Owner: jtrupiano
--

COPY distances (from_stadium_id, to_stadium_id, distance_in_miles, distance_in_minutes) FROM stdin;
1	2	1852	1766
1	3	2383	2273
1	4	2245	2160
1	5	2091	1988
1	6	1806	1706
1	7	1871	1766
1	8	2068	1985
1	9	1064	1003
1	10	820	837
1	11	2060	1953
1	12	1998	1896
1	13	1197	1092
1	14	1751	1661
1	15	2066	1940
1	16	1254	1253
1	17	2365	2228
1	18	1731	1684
1	19	2724	2614
1	20	1538	1431
1	21	2460	2415
1	22	2460	2415
1	23	726	706
1	24	2398	2344
1	25	2111	2034
1	26	345	350
1	27	747	731
1	28	1400	1421
1	29	1506	1413
1	30	2176	2052
1	31	1685	1586
1	32	2366	2259
28	29	2141	1998
28	30	3154	3020
28	31	2447	2308
28	32	2770	2707
29	30	1011	1026
29	31	305	314
29	32	838	873
30	31	708	700
30	32	917	937
31	32	683	679
2	3	696	692
2	4	886	889
2	5	244	245
2	6	715	733
2	7	460	451
2	8	709	715
2	9	798	808
2	10	1403	1366
2	11	723	717
2	12	920	939
2	13	801	778
2	14	534	542
2	15	320	339
2	16	795	806
2	17	650	645
2	18	1113	1130
2	19	1084	1106
2	20	470	456
2	21	879	884
2	22	879	884
2	23	2454	2365
2	24	793	798
2	25	684	687
2	26	2136	2063
2	27	2475	2390
2	28	2673	2577
2	29	553	567
2	30	461	469
2	31	247	257
2	32	652	674
3	4	366	411
3	5	457	467
3	6	699	719
3	7	503	523
3	8	371	403
3	9	1379	1347
3	10	1657	1619
3	11	525	547
3	12	903	926
3	13	1448	1418
3	14	575	587
3	15	751	748
3	16	1049	1059
3	17	1081	1068
3	18	1105	1148
3	19	394	435
3	20	1117	1097
3	21	190	213
3	22	190	213
3	23	2816	2715
3	24	99	110
3	25	247	270
3	26	2660	2595
3	27	2819	2718
3	28	2764	2703
3	29	814	834
3	30	950	955
3	31	697	690
3	32	33	46
4	5	650	644
4	6	526	516
4	7	427	420
4	8	182	181
4	9	1378	1334
4	10	1513	1451
4	11	285	294
4	12	730	723
4	13	1482	1468
4	14	495	478
4	15	1033	1033
4	16	969	951
4	17	1364	1352
4	18	932	945
4	19	459	478
4	20	1230	1188
4	21	380	390
4	22	380	390
4	23	2643	2512
4	24	393	408
4	25	209	203
4	26	2583	2463
4	27	2646	2516
4	28	2591	2500
4	29	734	726
4	30	1232	1240
4	31	697	678
4	32	378	439
5	6	765	764
5	7	476	470
5	8	515	502
5	9	1044	1052
5	10	1561	1506
5	11	630	635
5	12	969	971
5	13	1042	1019
5	14	583	573
5	15	385	394
5	16	953	947
5	17	715	714
5	18	1172	1193
5	19	847	872
5	20	711	698
5	21	643	650
5	22	643	650
5	23	2691	2570
5	24	557	564
5	25	448	454
5	26	2381	2307
5	27	2712	2594
5	28	2831	2718
5	29	711	708
5	30	584	602
5	31	406	398
5	32	411	437
6	7	295	311
6	8	344	358
6	9	985	966
6	10	1003	951
6	11	282	285
6	12	206	215
6	13	1089	1100
6	14	182	200
6	15	1033	1059
6	16	512	513
6	17	1364	1364
6	18	409	438
6	19	1008	993
6	20	924	898
6	21	786	816
6	22	786	816
6	23	2134	2012
6	24	762	801
6	25	460	475
6	26	2074	1963
6	27	2136	2016
6	28	2067	1992
6	29	295	304
6	30	1175	1188
6	31	468	476
6	32	705	749
7	8	252	268
7	9	952	923
7	10	1192	1147
7	11	264	270
7	12	498	514
7	13	1056	1057
7	14	112	118
7	15	779	788
7	16	583	587
7	17	1109	1094
7	18	701	736
7	19	908	897
7	20	804	777
7	21	641	695
7	22	641	695
7	23	2365	2249
7	24	579	623
7	25	291	313
7	26	2208	2120
7	27	2368	2252
7	28	2359	2290
7	29	362	360
7	30	920	918
7	31	271	267
7	32	516	553
8	9	1204	1167
8	10	1333	1277
8	11	172	171
8	12	550	550
8	13	1308	1301
8	14	321	312
8	15	900	891
8	16	795	784
8	17	1231	1210
8	18	753	772
8	19	662	641
8	20	1056	1021
8	21	461	481
8	22	461	481
8	23	2464	2339
8	24	436	466
8	25	135	140
8	26	2404	2290
8	27	2466	2342
8	28	2411	2326
8	29	560	559
8	30	1099	1098
8	31	524	511
8	32	380	414
9	10	783	817
9	11	1208	1182
9	12	1140	1129
9	13	264	265
9	14	916	885
9	15	1019	1020
9	16	521	528
9	17	1318	1308
9	18	959	958
9	19	1769	1754
9	20	527	524
9	21	1565	1532
9	22	1565	1532
9	23	1700	1637
9	24	1479	1446
9	25	1243	1229
9	26	1338	1265
9	27	1721	1662
9	28	2207	2082
9	29	648	646
9	30	1129	1132
9	31	684	653
9	32	1365	1326
10	11	1270	1201
10	12	1114	1060
10	13	1127	1076
10	14	1083	1033
10	15	1720	1689
10	16	610	560
10	17	2051	1994
10	18	913	853
10	19	1997	1910
10	20	1369	1307
10	21	1775	1733
10	22	1775	1733
10	23	1269	1190
10	24	1730	1716
10	25	1448	1392
10	26	1073	1018
10	27	1271	1194
10	28	1330	1257
10	29	849	796
10	30	1862	1818
10	31	1155	1106
10	32	1681	1651
11	12	488	498
11	13	1319	1316
11	14	313	305
11	15	1013	1026
11	16	787	777
11	17	1372	1353
11	18	691	720
11	19	716	752
11	20	1067	1037
11	21	612	636
11	22	612	636
11	23	2399	2283
11	24	588	621
11	25	286	295
11	26	2339	2234
11	27	2402	2287
11	28	2349	2275
11	29	552	552
11	30	1183	1177
11	31	534	527
11	32	532	570
12	13	1296	1325
12	14	389	425
12	15	1240	1284
12	16	625	627
12	17	1570	1590
12	18	276	286
12	19	1215	1218
12	20	1131	1123
12	21	993	1041
12	22	993	1041
12	23	2230	2116
12	24	968	1026
12	25	666	700
12	26	2170	2067
12	27	2232	2119
12	28	1934	1840
12	29	484	502
12	30	1382	1414
12	31	675	702
12	32	912	975
13	14	1024	1030
13	15	882	865
13	16	750	756
13	17	1181	1153
13	18	1187	1186
13	19	1839	1834
13	20	354	357
13	21	1634	1612
13	22	1634	1612
13	23	1913	1778
13	24	1548	1526
13	25	1351	1374
13	26	1471	1349
13	27	1934	1803
13	28	2448	2326
13	29	845	851
13	30	992	977
13	31	792	798
13	32	1435	1406
14	15	851	866
14	16	475	476
14	17	1181	1171
14	18	589	627
14	19	974	959
14	20	819	794
14	21	710	760
14	22	710	760
14	23	2253	2136
14	24	648	689
14	25	361	379
14	26	2086	2012
14	27	2255	2139
14	28	2247	2182
14	29	240	251
14	30	992	995
14	31	286	283
14	32	599	625
15	16	1114	1132
15	17	332	324
15	18	1432	1456
15	19	1139	1184
15	20	551	518
15	21	935	962
15	22	935	962
15	23	2782	2601
15	24	844	859
15	25	831	828
15	26	2341	2172
15	27	2803	2626
15	28	2992	2904
15	29	872	894
15	30	209	222
15	31	567	584
15	32	724	724
16	17	1442	1440
16	18	439	437
16	19	1448	1432
16	20	840	839
16	21	1184	1233
16	22	1184	1233
16	23	1818	1712
16	24	1122	1162
16	25	835	852
16	26	1682	1582
16	27	1820	1716
16	28	1879	1779
16	29	241	243
16	30	1254	1264
16	31	547	553
16	32	1073	1097
17	18	1763	1752
17	19	1471	1508
17	20	850	810
17	21	1266	1286
17	22	1266	1286
17	23	3081	2893
17	24	1175	1183
17	25	1162	1152
17	26	2640	2464
17	27	3102	2918
17	28	3322	3199
17	29	1202	1189
17	30	270	266
17	31	897	879
17	32	1055	1048
18	19	1415	1424
18	20	1221	1184
18	21	1193	1247
18	22	1193	1247
18	23	2044	1916
18	24	1168	1232
18	25	866	906
18	26	1984	1867
18	27	2046	1919
18	28	1659	1558
18	29	560	566
18	30	1572	1587
18	31	866	875
18	32	1112	1181
19	20	1509	1498
19	21	206	233
19	22	206	233
19	23	3098	2976
19	24	302	337
19	25	572	616
19	26	3038	2927
19	27	3100	2980
19	28	3045	2964
19	29	1188	1190
19	30	1342	1382
19	31	1088	1092
19	32	426	472
20	21	1303	1277
20	22	1303	1277
20	23	2254	2110
20	24	1217	1191
20	25	1090	1064
20	26	1813	1680
20	27	2276	2135
20	28	2682	2562
20	29	677	645
20	30	660	643
20	31	532	500
20	32	1103	1071
21	22	0	0
21	23	2901	2792
21	24	96	110
21	25	371	391
21	26	2794	2728
21	27	2904	2796
21	28	2849	2780
21	29	948	967
21	30	1137	1156
21	31	882	865
21	32	220	246
22	23	2901	2792
22	24	96	110
22	25	371	391
22	26	2794	2728
22	27	2904	2796
22	28	2849	2780
22	29	948	967
22	30	1137	1156
22	31	882	865
22	32	220	246
23	24	2879	2775
23	25	2577	2449
23	26	484	483
23	27	21	27
23	28	807	817
23	29	2056	1944
23	30	2893	2746
23	31	2288	2173
23	32	2823	2724
24	25	310	331
24	26	2734	2667
24	27	2882	2780
24	28	2827	2764
24	29	888	906
24	30	1045	1060
24	31	795	795
24	32	128	150
25	26	2447	2375
25	27	2581	2460
25	28	2526	2444
25	29	601	614
25	30	1031	1052
25	31	561	561
25	32	253	289
26	27	503	499
26	28	1253	1256
26	29	1801	1741
26	30	2449	2299
26	31	2019	1897
26	32	2701	2570
27	28	812	828
27	29	2061	1955
27	30	2914	2771
27	31	2309	2198
27	32	2827	2734
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: jtrupiano
--

COPY games (id, home_stadium_id, away_stadium_id, gametime) FROM stdin;
1	21	9	2012-09-05 20:30:00
2	6	14	2012-09-09 13:00:00
3	8	24	2012-09-09 13:00:00
4	31	19	2012-09-09 13:00:00
5	16	2	2012-09-09 13:00:00
6	18	15	2012-09-09 13:00:00
7	20	32	2012-09-09 13:00:00
8	22	4	2012-09-09 13:00:00
9	11	29	2012-09-09 13:00:00
10	13	17	2012-09-09 13:00:00
11	12	27	2012-09-09 16:15:00
12	1	28	2012-09-09 16:15:00
13	30	5	2012-09-09 16:15:00
14	10	25	2012-09-09 20:20:00
15	3	7	2012-09-10 19:00:00
16	23	26	2012-09-10 22:15:00
17	12	6	2012-09-13 20:20:00
18	4	16	2012-09-16 13:00:00
19	7	8	2012-09-16 13:00:00
20	14	18	2012-09-16 13:00:00
21	5	20	2012-09-16 13:00:00
22	15	13	2012-09-16 13:00:00
23	19	1	2012-09-16 13:00:00
24	21	30	2012-09-16 13:00:00
25	24	3	2012-09-16 13:00:00
26	29	32	2012-09-16 16:05:00
27	28	9	2012-09-16 16:05:00
28	17	23	2012-09-16 16:15:00
29	25	22	2012-09-16 16:15:00
30	26	31	2012-09-16 16:15:00
31	27	11	2012-09-16 20:20:00
32	2	10	2012-09-17 20:30:00
33	5	21	2012-09-20 20:20:00
34	6	29	2012-09-23 13:00:00
35	8	4	2012-09-23 13:00:00
36	9	30	2012-09-23 13:00:00
37	17	22	2012-09-23 13:00:00
38	18	27	2012-09-23 13:00:00
39	20	16	2012-09-23 13:00:00
40	32	7	2012-09-23 13:00:00
41	31	11	2012-09-23 13:00:00
42	14	15	2012-09-23 13:00:00
43	1	24	2012-09-23 16:05:00
44	26	2	2012-09-23 16:05:00
45	10	13	2012-09-23 16:15:00
46	23	25	2012-09-23 16:15:00
47	3	19	2012-09-23 20:20:00
48	28	12	2012-09-24 20:30:00
49	3	8	2012-09-27 20:20:00
50	2	5	2012-09-30 13:00:00
51	4	19	2012-09-30 13:00:00
52	11	18	2012-09-30 13:00:00
53	16	26	2012-09-30 13:00:00
54	29	28	2012-09-30 13:00:00
55	22	27	2012-09-30 13:00:00
56	13	31	2012-09-30 13:00:00
57	1	17	2012-09-30 16:05:00
58	15	7	2012-09-30 16:05:00
59	10	23	2012-09-30 16:05:00
60	12	20	2012-09-30 16:15:00
61	30	32	2012-09-30 16:15:00
62	24	21	2012-09-30 20:20:00
63	9	6	2012-10-01 20:30:00
64	29	1	2012-10-04 20:20:00
65	7	17	2012-10-07 13:00:00
66	14	12	2012-10-07 13:00:00
67	16	3	2012-10-07 13:00:00
68	18	31	2012-10-07 13:00:00
69	32	2	2012-10-07 13:00:00
70	21	8	2012-10-07 13:00:00
71	25	24	2012-10-07 13:00:00
72	5	28	2012-10-07 16:05:00
73	15	6	2012-10-07 16:05:00
74	19	10	2012-10-07 16:15:00
75	27	4	2012-10-07 16:15:00
76	20	26	2012-10-07 20:20:00
77	22	13	2012-10-08 20:30:00
78	31	25	2012-10-11 20:20:00
79	2	23	2012-10-14 13:00:00
80	8	7	2012-10-14 13:00:00
81	17	29	2012-10-14 13:00:00
82	22	14	2012-10-14 13:00:00
83	24	11	2012-10-14 13:00:00
84	3	9	2012-10-14 13:00:00
85	30	16	2012-10-14 13:00:00
86	28	19	2012-10-14 16:05:00
87	1	4	2012-10-14 16:05:00
88	27	21	2012-10-14 16:15:00
89	32	18	2012-10-14 16:15:00
90	13	12	2012-10-14 20:20:00
91	26	10	2012-10-15 20:30:00
92	27	28	2012-10-18 20:20:00
93	4	31	2012-10-21 13:00:00
94	14	8	2012-10-21 13:00:00
95	21	32	2012-10-21 13:00:00
96	30	20	2012-10-21 13:00:00
97	5	9	2012-10-21 13:00:00
98	13	3	2012-10-21 13:00:00
99	29	12	2012-10-21 13:00:00
100	18	1	2012-10-21 13:00:00
101	19	22	2012-10-21 16:15:00
102	23	15	2012-10-21 16:15:00
103	7	25	2012-10-21 20:20:00
104	6	11	2012-10-22 20:30:00
105	18	30	2012-10-25 20:20:00
106	6	5	2012-10-28 13:00:00
107	8	26	2012-10-28 13:00:00
108	11	28	2012-10-28 13:00:00
109	12	15	2012-10-28 13:00:00
110	31	14	2012-10-28 13:00:00
111	29	19	2012-10-28 13:00:00
112	22	17	2012-10-28 13:00:00
113	24	2	2012-10-28 13:00:00
114	25	32	2012-10-28 13:00:00
115	16	23	2012-10-28 16:05:00
116	9	21	2012-10-28 16:15:00
117	10	20	2012-10-28 20:20:00
118	1	27	2012-10-29 20:30:00
119	26	16	2012-11-01 20:20:00
120	7	10	2012-11-04 13:00:00
121	8	3	2012-11-04 13:00:00
122	12	1	2012-11-04 13:00:00
123	31	6	2012-11-04 13:00:00
124	14	17	2012-11-04 13:00:00
125	32	5	2012-11-04 13:00:00
126	15	11	2012-11-04 13:00:00
127	13	4	2012-11-04 13:00:00
128	23	30	2012-11-04 16:05:00
129	28	18	2012-11-04 16:05:00
130	21	25	2012-11-04 16:15:00
131	2	9	2012-11-04 20:20:00
132	20	24	2012-11-05 20:30:00
133	15	14	2012-11-08 20:20:00
134	7	21	2012-11-11 13:00:00
135	17	31	2012-11-11 13:00:00
136	18	11	2012-11-11 13:00:00
137	19	4	2012-11-11 13:00:00
138	20	2	2012-11-11 13:00:00
139	30	26	2012-11-11 13:00:00
140	5	10	2012-11-11 13:00:00
141	3	23	2012-11-11 13:00:00
142	28	22	2012-11-11 16:05:00
143	24	9	2012-11-11 16:15:00
144	27	29	2012-11-11 16:15:00
145	6	13	2012-11-11 20:20:00
146	25	16	2012-11-12 20:30:00
147	4	17	2012-11-15 20:20:00
148	2	1	2012-11-18 13:00:00
149	9	8	2012-11-18 13:00:00
150	11	12	2012-11-18 13:00:00
151	16	7	2012-11-18 13:00:00
152	29	22	2012-11-18 13:00:00
153	19	14	2012-11-18 13:00:00
154	32	24	2012-11-18 13:00:00
155	5	30	2012-11-18 13:00:00
156	13	15	2012-11-18 13:00:00
157	23	20	2012-11-18 16:05:00
158	10	26	2012-11-18 16:15:00
159	25	3	2012-11-18 20:20:00
160	27	6	2012-11-19 20:30:00
161	11	13	2012-11-22 12:30:00
162	9	32	2012-11-22 16:15:00
163	22	19	2012-11-22 20:20:00
164	6	18	2012-11-25 13:00:00
165	7	23	2012-11-25 13:00:00
166	8	25	2012-11-25 13:00:00
167	14	4	2012-11-25 13:00:00
168	16	10	2012-11-25 13:00:00
169	17	28	2012-11-25 13:00:00
170	30	2	2012-11-25 13:00:00
171	15	31	2012-11-25 13:00:00
172	26	3	2012-11-25 16:05:00
173	1	29	2012-11-25 16:15:00
174	20	27	2012-11-25 16:15:00
175	21	12	2012-11-25 20:20:00
176	24	5	2012-11-26 20:30:00
177	2	20	2012-11-29 20:20:00
178	4	15	2012-12-02 13:00:00
179	6	28	2012-12-02 13:00:00
180	11	14	2012-12-02 13:00:00
181	12	18	2012-12-02 13:00:00
182	31	13	2012-12-02 13:00:00
183	16	5	2012-12-02 13:00:00
184	29	27	2012-12-02 13:00:00
185	17	19	2012-12-02 13:00:00
186	22	1	2012-12-02 13:00:00
187	10	30	2012-12-02 16:05:00
188	26	7	2012-12-02 16:15:00
189	23	8	2012-12-02 16:15:00
190	3	25	2012-12-02 16:15:00
191	9	24	2012-12-02 20:20:00
192	32	21	2012-12-03 20:30:00
193	23	10	2012-12-06 20:20:00
194	4	29	2012-12-09 13:00:00
195	7	9	2012-12-09 13:00:00
196	8	16	2012-12-09 13:00:00
197	30	24	2012-12-09 13:00:00
198	32	3	2012-12-09 13:00:00
199	5	2	2012-12-09 13:00:00
200	15	22	2012-12-09 13:00:00
201	14	31	2012-12-09 13:00:00
202	18	6	2012-12-09 13:00:00
203	25	26	2012-12-09 13:00:00
204	27	17	2012-12-09 16:05:00
205	28	1	2012-12-09 16:15:00
206	21	20	2012-12-09 16:15:00
207	12	11	2012-12-09 20:20:00
208	19	13	2012-12-10 20:30:00
209	24	7	2012-12-13 20:20:00
210	2	21	2012-12-16 13:00:00
211	6	12	2012-12-16 13:00:00
212	8	32	2012-12-16 13:00:00
213	29	18	2012-12-16 13:00:00
214	17	15	2012-12-16 13:00:00
215	20	30	2012-12-16 13:00:00
216	3	10	2012-12-16 13:00:00
217	13	14	2012-12-16 13:00:00
218	1	11	2012-12-16 16:05:00
219	26	5	2012-12-16 16:05:00
220	4	28	2012-12-16 16:05:00
221	9	25	2012-12-16 16:15:00
222	23	16	2012-12-16 16:15:00
223	19	27	2012-12-16 20:20:00
224	31	22	2012-12-17 20:30:00
225	11	2	2012-12-22 20:30:00
226	9	20	2012-12-23 13:00:00
227	12	31	2012-12-23 13:00:00
228	16	14	2012-12-23 13:00:00
229	17	4	2012-12-23 13:00:00
230	24	32	2012-12-23 13:00:00
231	25	7	2012-12-23 13:00:00
232	30	29	2012-12-23 13:00:00
233	5	23	2012-12-23 13:00:00
234	15	19	2012-12-23 13:00:00
235	3	21	2012-12-23 13:00:00
236	13	18	2012-12-23 13:00:00
237	10	8	2012-12-23 16:05:00
238	28	27	2012-12-23 16:15:00
239	1	6	2012-12-23 16:15:00
240	22	26	2012-12-23 20:20:00
241	2	30	2012-12-30 13:00:00
242	4	22	2012-12-30 13:00:00
243	7	3	2012-12-30 13:00:00
244	11	6	2012-12-30 13:00:00
245	31	15	2012-12-30 13:00:00
246	14	13	2012-12-30 13:00:00
247	18	12	2012-12-30 13:00:00
248	19	17	2012-12-30 13:00:00
249	20	5	2012-12-30 13:00:00
250	21	24	2012-12-30 13:00:00
251	25	8	2012-12-30 13:00:00
252	32	9	2012-12-30 13:00:00
253	26	23	2012-12-30 16:15:00
254	27	1	2012-12-30 16:15:00
255	28	29	2012-12-30 16:15:00
256	10	16	2012-12-30 16:15:00
\.


--
-- Data for Name: stadiums; Type: TABLE DATA; Schema: public; Owner: jtrupiano
--

COPY stadiums (id, team, stadium, address) FROM stdin;
1	Arizona Cardinals	University of Phoenix Stadium	One Cardinals Drive, Glendale, AZ 85305
2	Atlanta Falcons	Georgia Dome	One Georgia Dome Drive, N.W., Atlanta, Georgia 30313
3	Baltimore Ravens	M&T Bank Stadium	1101 Russell Street, Baltimore, Maryland 21230
4	Buffalo Bills	Ralph Wilson Stadium	One Bills Drive, Orchard Park, New York 14127
5	Carolina Panthers	Bank of America Stadium	800 South Mint Street Charlotte, North Carolina 28202
6	Chicago Bears	Soldier Field	1410 South Museum Campus Dr, Chicago, Illinois 60605
7	Cincinnati Bengals	Paul Brown Stadium	One Paul Brown Stadium, Cincinnati, Ohio 45202
8	Cleveland Browns	Cleveland Browns Stadium	1085 West Third Street, Cleveland, Ohio 44114
9	Dallas Cowboys	Cowboys Stadium	925 N Collins St, Arlington, TX
10	Denver Broncos	Invesco Field at Mile High	1701 Bryant Street, Denver, Colorado 80204
11	Detroit Lions	Ford Field	2000 Brush Street, Detroit, Michigan 48226
12	Green Bay Packers	Lambeau Field	1265 Lombardi Avenue, Green Bay, Wisconsin 54307
13	Houston Texans	Reliant Stadium	One Reliant Park, Houston, Texas 77054
14	Indianapolis Colts	Lucas Oil Stadium	500 South Capitol Ave, Indianapolis, IN 46225
15	Jacksonville Jaguars	EverBank Field	1 Stadium Pl, Jacksonville, FL 32202
16	Kansas City Chiefs	Arrowhead Stadium	1 Arrowhead Drive, Kansas City, Missouri 64129
17	Miami Dolphins	Sun Life Stadium	2269 Dan Marino Boulevard, Miami Gardens, Florida 33056
18	Minnesota Vikings	Hubert H. Humphrey Metrodome	900 South Fifth Street, Minneapolis, Minnesota 55415
19	New England Patriots	Gillette Stadium	One Patriot Place Foxborough, Massachusetts 02035
20	New Orleans Saints	Louisiana Superdome	1500 Poydras Street, New Orleans, Louisiana 70112
21	New York Giants	New Meadowlands Stadium	102 Route 120, East Rutherford, NJ 07073 
22	New York Jets	New Meadowlands Stadium	102 Route 120, East Rutherford, NJ 07073 
23	Oakland Raiders	Oakland-Alameda County Coliseum	7000 Coliseum Way, Oakland, California 94621
24	Philadelphia Eagles	Lincoln Financial Field	3501 South Broad Street, Philadelphia, Pennsylvania 19101
25	Pittsburgh Steelers	Heinz Field	100 Art Rooney Avenue, Pittsburgh, Pennsylvania 15212
26	San Diego Chargers	Qualcomm Stadium	9449 Friars Rd, San Diego, CA 92108
27	San Francisco 49ers	Candlestick Park	602 Jamestown Avenue, San Francisco, California 94124
28	Seattle Seahawks	Qwest Field	800 Occidental Avenue S., Seattle, Washington 98134-1200
29	St. Louis Rams	Edward Jones Dome	701 Convention Plaza, St. Louis, Missouri 63101
30	Tampa Bay Buccaneers	Raymond James Stadium	One Buccaneer Place, Tampa, Florida 33607
31	Tennessee Titans	LP Field	One Titans Way, Nashville, Tennessee 37213
32	Washington Redskins	FedExField	1600 FedEx Way, Landover, MD 20785
\.


--
-- Name: games_pkey; Type: CONSTRAINT; Schema: public; Owner: jtrupiano; Tablespace: 
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: stadiums_pkey; Type: CONSTRAINT; Schema: public; Owner: jtrupiano; Tablespace: 
--

ALTER TABLE ONLY stadiums
    ADD CONSTRAINT stadiums_pkey PRIMARY KEY (id);


--
-- Name: distances_from_stadium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jtrupiano
--

ALTER TABLE ONLY distances
    ADD CONSTRAINT distances_from_stadium_id_fkey FOREIGN KEY (from_stadium_id) REFERENCES stadiums(id);


--
-- Name: distances_to_stadium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jtrupiano
--

ALTER TABLE ONLY distances
    ADD CONSTRAINT distances_to_stadium_id_fkey FOREIGN KEY (to_stadium_id) REFERENCES stadiums(id);


--
-- Name: games_away_stadium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jtrupiano
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_away_stadium_id_fkey FOREIGN KEY (away_stadium_id) REFERENCES stadiums(id);


--
-- Name: games_home_stadium_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jtrupiano
--

ALTER TABLE ONLY games
    ADD CONSTRAINT games_home_stadium_id_fkey FOREIGN KEY (home_stadium_id) REFERENCES stadiums(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: jtrupiano
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM jtrupiano;
GRANT ALL ON SCHEMA public TO jtrupiano;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
